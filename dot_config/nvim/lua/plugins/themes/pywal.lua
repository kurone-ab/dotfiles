return {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",

    config = function()
        if vim.fn.filereadable(vim.fn.expand("~/.cache/wal/colors-wal.vim")) == 1 then
            require("pywal").setup()
        end
    end,
}
