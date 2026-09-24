set-alias vi 'C:\Program Files\Vim\vim91\vim.exe'
set-alias vim 'C:\Program Files\Vim\vim91\vim.exe'


# ghq + fzf でリポジトリを選択して cd する関数
function Set-GhqDirectory {
    $repo = ghq list -p | fzf --preview 'cmd /c dir /b "{}"'
    if ($repo) {
        Set-Location $repo
    }
}

# ショートカットキー（Ctrl + g）の割り当て
Set-PSReadLineKeyHandler -Chord 'Ctrl+g' -ScriptBlock {
    $repo = ghq list -p | fzf --preview 'cmd /c dir /b "{}"'
    if ($repo) {
        # 現在の行をクリアして cd コマンドを挿入し実行
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("cd `"$repo`"")
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
}