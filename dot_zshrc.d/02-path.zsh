# asdf
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# autoload -Uz compinit && compinit -- zsh-autocomplete로 대체
. ~/.asdf/plugins/java/set-java-home.zsh

# Android setting
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Claude Code Templates - Global Agents
export PATH="$HOME/.claude-code-templates/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
