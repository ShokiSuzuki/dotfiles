return {
      "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- 保存前に実行するためのイベント
    cmd = { "ConformInfo" },
    opts = {
    -- 言語ごとのフォーマッタを指定（システムにインストールされている必要があります）
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "black" }, -- 左から順に試行
        cpp = { "clang-format" },
        c_sharp = { "csharpier" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    -- 保存時の自動フォーマット設定
    format_on_save = {
        timeout_ms = 500, -- 500ms以内に終わらない場合はタイムアウト
        lsp_format = "fallback", -- 指定フォーマッタがなければLSPのフォーマットを試す
    },
  },
}
