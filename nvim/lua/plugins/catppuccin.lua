return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- 他のプラグインより先に読み込むための設定
        config = function()
            require("catppuccin").setup({
                flavour = "catppuccin-latte", -- latte, frappe, macchiato, mocha から選べます
            })
        end,
    },
}
