/**
 * cc-filter OpenCode Plugin
 *
 * Claude Code hook 설정을 OpenCode 플러그인으로 포팅.
 *
 * 원본 Claude Code 설정:
 *   PreToolUse:       matcher "*"  → cc-filter (모든 도구 실행 전 민감정보 필터링)
 *   UserPromptSubmit:              → cc-filter (사용자 프롬프트 제출 전 필터링)
 *   SessionEnd:                    → cc-filter (세션 종료 시 정리)
 *
 * OpenCode 매핑:
 *   tool.execute.before → PreToolUse
 *   chat.message        → UserPromptSubmit
 *   event (session.*)   → SessionEnd
 *
 * 사용법:
 *   .opencode/plugins/cc-filter-plugin.js 에 배치
 *   cc-filter 바이너리가 PATH에 있어야 함
 */

export const CcFilterPlugin = async ({ $, client }) => {
  const CC_FILTER_CMD = process.env.CC_FILTER_CMD || "cc-filter";

  /**
   * cc-filter 바이너리를 실행하고 결과를 반환한다.
   *
   * @param {string} hookType - 훅 종류 (PreToolUse, UserPromptSubmit, SessionEnd)
   * @param {object|string} payload - cc-filter에 전달할 데이터
   * @param {{ raw?: boolean }} opts - raw: true이면 payload를 평문 그대로 전달
   * @returns {{ allowed: boolean, output: string }}
   */
  async function runCcFilter(hookType, payload, opts = {}) {
    const input = opts.raw
      ? String(payload)
      : JSON.stringify({ hook: hookType, ...payload });

    try {
      const result = await $`echo ${input} | ${CC_FILTER_CMD}`
        .quiet()
        .nothrow();

      if (result.exitCode === 2) {
        // exit code 2 = 차단 (민감정보가 마스킹 불가하거나 정책상 거부)
        return { allowed: false, output: result.stdout.toString().trim() };
      }

      if (result.exitCode !== 0) {
        await client?.app?.log?.({
          body: {
            service: "cc-filter",
            level: "warn",
            message: `cc-filter exited with code ${result.exitCode}`,
            extra: { stderr: result.stderr.toString(), hookType },
          },
        });
        return { allowed: true, output: "" };
      }

      // exit code 0 = 통과 (민감정보가 없거나, 마스킹 처리된 결과가 stdout에 출력됨)
      return { allowed: true, output: result.stdout.toString().trim() };
    } catch (err) {
      await client?.app?.log?.({
        body: {
          service: "cc-filter",
          level: "error",
          message: `cc-filter execution failed: ${err.message}`,
          extra: { hookType },
        },
      });
      // cc-filter 실행 실패 시 안전하게 차단 (fail-closed)
      return { allowed: false, output: "" };
    }
  }

  return {
    /**
     * PreToolUse 대응: 모든 도구 실행 전 민감정보 필터링
     * matcher: "*" 와 동일하게 모든 도구에 적용
     */
    "tool.execute.before": async (input, output) => {
      const payload = {
        tool: input.tool,
        args: output.args,
      };

      const result = await runCcFilter("PreToolUse", payload);

      if (!result.allowed) {
        throw new Error(
          `[cc-filter] 민감정보가 감지되어 도구 실행이 차단되었습니다: ${input.tool}`,
        );
      }

      // cc-filter가 redact된 args를 stdout으로 반환하면 적용
      if (result.output) {
        try {
          const filtered = JSON.parse(result.output);
          if (filtered.args) {
            Object.assign(output.args, filtered.args);
          }
        } catch {
          // JSON 파싱 실패 시 원본 args 유지
        }
      }
    },

    /**
     * UserPromptSubmit 대응: 사용자 메시지 필터링
     *
     * chat.message 시그니처: (_input: {}, output: { message, parts }) => void
     * parts 배열에서 type === "text"인 항목의 text 필드를 필터링
     */
    "chat.message": async (_input, output) => {
      const { parts } = output;
      if (!parts?.length) return;

      const textParts = parts.filter((p) => p.type === "text");
      if (!textParts.length) return;

      const content = textParts.map((p) => p.text).join("\n");

      const result = await runCcFilter("UserPromptSubmit", content, {
        raw: true,
      });

      if (!result.allowed) {
        throw new Error(
          "[cc-filter] 프롬프트에서 민감정보가 감지되었습니다. 민감정보를 제거한 후 다시 시도하세요.",
        );
      }

      // 마스킹된 평문을 parts에 반영
      if (result.output) {
        if (textParts.length === 1) {
          textParts[0].text = result.output;
        }
      }
    },

    /**
     * SessionEnd 대응: 세션 종료/유휴 시 cc-filter 정리 작업
     */
    event: async ({ event }) => {
      if (event.type === "session.idle" || event.type === "session.deleted") {
        await runCcFilter("SessionEnd", {
          sessionEvent: event.type,
          data: event.properties ?? {},
        });
      }
    },
  };
};
