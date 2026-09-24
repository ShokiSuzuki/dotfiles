-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("config.lazy")
vim.cmd.colorscheme("catppuccin-frappe")

require("nvim-tree").setup()

-- 💡 画面に nvim-tree だけが残ったら自動的に Neovim を終了する設定
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
      vim.cmd("confirm quit")
    end
  end,
})

require("CopilotChat").setup({
    show_help = "yes",
    prompts = {
        Explain = {
            prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
            mapping = '<leader>ce',
            description = "コードの説明をお願いする",
        },
        Review = {
            prompt = '/COPILOT_REVIEW コードを日本語でレビューしてください。',
            mapping = '<leader>cr',
            description = "コードのレビューをお願いする",
        },
        Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
            mapping = '<leader>cf',
            description = "コードの修正をお願いする",
        },
        Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
            mapping = '<leader>co',
            description = "コードの最適化をお願いする",
        },
        Docs = {
            prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
            mapping = '<leader>cd',
            description = "コードのドキュメント作成をお願いする",
        },
        Tests = {
            prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
            mapping = '<leader>ct',
            description = "テストコード作成をお願いする",
        },
        FixDiagnostic = {
            prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。',
            mapping = '<leader>cd',
            description = "コードの修正をお願いする",
            selection = require('CopilotChat.select').diagnostics,
        },
        Commit = {
            prompt =
            '実装差分に対するコミットメッセージを日本語で記述してください。',
            mapping = '<leader>cco',
            description = "コミットメッセージの作成をお願いする",
            selection = require('CopilotChat.select').gitdiff,
        },
        CommitStaged = {
            prompt =
            'ステージ済みの変更に対するコミットメッセージを日本語で記述してください。',
            mapping = '<leader>cs',
            description = "ステージ済みのコミットメッセージの作成をお願いする",
            selection = function(source)
                return require('CopilotChat.select').gitdiff(source, true)
            end,
        },
    },
})

