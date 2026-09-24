return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- 挿入モードに入った時に読み込む（起動を速くするため）
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Treesitterを利用して、より正確に補完する設定（推奨）
        disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- 特定の画面では無効化
      })
    end,
  },
}
