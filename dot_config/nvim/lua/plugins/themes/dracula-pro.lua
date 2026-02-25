return {
    dir = "/Users/kurone/.local/share/nvim/site/pack/themes/start/dracula_pro",
    name = "dracula_pro",
    priority = 1000,
    config = function()
        vim.g.dracula_colorterm = 0
        vim.cmd("colorscheme dracula_pro_van_helsing")
    end,
}

