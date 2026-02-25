return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true, -- Toggle with ':Gitsigns toggle_signs'
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 0,
                ignore_whitespace = false,
            },
        })

        -- Git blame 색상 설정
        vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
            fg = '#6c7086', -- 회색 계열 (원하는 색상으로 변경)
            italic = true,
            bg = 'NONE'     -- 배경 투명
        })
    end,
}
