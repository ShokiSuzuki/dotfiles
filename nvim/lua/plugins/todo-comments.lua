return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- 💡 ここでお好みのキーワードやアイコンをカスタマイズできますが、
            -- デフォルトでも十分に使いやすい設定になっています。
        },
        config = function(_, opts)
            require("todo-comments").setup(opts)
            -- 💡 便利なショートカットキーの設定
            -- 1. 次のTODOへ移動 ( ]t )
            vim.keymap.set("n", "]t", function()
              require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })
            -- 2. 前のTODOへ移動 ( [t )
            vim.keymap.set("n", "[t", function()
              require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
            -- 3. プロジェクト内のTODOを一覧表示 (Space + f + t) ※Telescopeが必要
            vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
        end,
    },
}
