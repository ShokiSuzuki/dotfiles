return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local powershell_options = {
        -- Windows標準の PowerShell 5.1 を使う場合
        shell = "powershell.exe",
        -- shell = "pwsh.exe",
        
        -- WindowsのPowerShellで日本語（UTF-8）の文字化けを防ぐための推奨オプション
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "2>&1 | Out-File -Encoding UTF8 %s",
        shellpipe = "|",
        shellquote = "",
        shellxquote = "",
      }

      require("toggleterm").setup({
        -- 💡 ここで作成した PowerShell の設定を toggleterm に適用します
        shell = powershell_options.shell,
        -- Neovim全体のシェル設定もPowerShellに合わせるための、文字化け・引数エラー防止用オプション
        -- (これを省略すると、toggleterm内でのコマンド実行が失敗することがあります)
        exec = {
          shellcmdflag = powershell_options.shellcmdflag,
          shellredir = powershell_options.shellredir,
          shellpipe = powershell_options.shellpipe,
          shellquote = powershell_options.shellquote,
          shellxquote = powershell_options.shellxquote,
        },

        open_mapping = [[<c-t>]],
        direction = "horizontal", 
        start_in_insert = true,
        size = 15,
        float_opts = {
          border = "curved",
        },
      })

      -- 💡 ターミナル内での便利なキーマップ設定
      -- ターミナルが開いている状態で特定の操作をしやすくします
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- ターミナル内で `Esc` を押すと、ターミナルのノーマルモードに戻る
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        -- ターミナル間やウィンドウ間の移動をスムーズにする設定
        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      -- ターミナルを開いたときだけ上記のキーマップを有効にする
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },
}
