return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8", -- 安定版のタグを指定
        dependencies = {
            "nvim-lua/plenary.nvim", -- Telescopeの動作に必要な共通ライブラリ
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
        },
        config = function()
            local builtin = require("telescope.builtin")
            -- 💡 便利なショートカットキー（キーマップ）の設定
            -- リーダーキー（スペース）に続く2打鍵で各検索を起動します
            
            -- 1. プロジェクト内のファイル名検索（Space + f + f）
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            
            -- 2. プロジェクト内の文字列検索（Space + f + g）※ripgrepが必要
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            
            -- 3. 現在開いているバッファ（ファイル）一覧（Space + f + b）
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
            
            -- 4. ヘルプタグの検索（Space + f + h）
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        end,
    },
}
