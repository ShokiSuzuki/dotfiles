return {
    {
        "simeji/winresizer",
        -- winresizerはVimスクリプト製で設定がシンプルなため、
        -- 起動時に読み込む設定だけで動作します
        init = function()
            -- 💡 必要に応じてここにカスタム設定（ショートカットキーの変更など）を書けます
            -- 初期状態の起動キーを変更したい場合は、以下のように設定します（例: Ctrl + x）
            -- vim.g.winresizer_start_key = '<C-x>'
        end,
    },
}
