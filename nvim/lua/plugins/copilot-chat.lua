return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- 先ほど入れたCopilotコアプラグインに依存
            { "nvim-lua/plenary.nvim" },   -- Telescope等でも使っている共通ライブラリ
        },
        opts = {
            debug = false, -- デバッグログを出力する場合は true
            -- 💡 デフォルトのプロンプトを日本語に設定
            language = "ja", 
            -- チャットウィンドウの表示スタイル（'vertical', 'horizontal', 'float'）
            window = {
                layout = "vertical", 
                width = 0.4, -- 画面の40%の幅で右側に開く
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)
            -- 💡 便利なショートカットキー（キーマップ）の設定
            -- 1. チャットウィンドウの開閉（Space + c + c）
            vim.keymap.set("n", "<leader>cc", function()
            chat.toggle()
            end, { desc = "Toggle Copilot Chat" })
            -- 2. 選択したコードに対するクイックチャット（Space + c + q）
            -- 読み方: ビジュアルモードでコードを選んで実行すると、そのコードについて質問できます
            vim.keymap.set("v", "<leader>cq", function()
                local input = vim.fn.input("Copilotへの質問: ")
                if input ~= "" then
                    chat.ask(input, { selection = require("CopilotChat.select").visual })
                end
            end, { desc = "CopilotChat - Quick ask" })
            -- 3. よく使うプロンプト（コードの解説やバグ修正）をメニューから選択（Space + c + p）
            vim.keymap.set({"n", "v"}, "<leader>cp", function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end, { desc = "CopilotChat - Prompt actions" })
        end,
    },
}
