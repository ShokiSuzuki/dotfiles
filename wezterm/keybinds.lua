local wezterm = require("wezterm")
local act = wezterm.action


-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

return {
keys = {
  -- ==================================================================
  -- タブ操作 (Chrome/ブラウザ風)
  -- ==================================================================
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- ==================================================================
  -- ペーン分割 (LEADER + キー)
  -- ==================================================================
  -- 左右分割 ( \ キー)
  { key = '\\', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- 上下分割 ( - キー)
  { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- ペーンを最大化 / 復元 ( TogglePaneZoom )
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- ==================================================================
  -- ペーン移動 (Vimキーバインド: LEADER + h/j/k/l)
  -- ==================================================================
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- ==================================================================
  -- ペーンのサイズ調整 (LEADER + Arrow)
  -- ==================================================================
  { key = 'LeftArrow', mods = 'LEADER', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow', mods = 'LEADER', action = act.AdjustPaneSize { 'Down', 5 } },

  -- ==================================================================
  -- 便利機能 (QuickSelect / コピーモード)
  -- ==================================================================
  -- 画面上のテキストを素早く選択してクリップボードにコピー
  { key = 'f', mods = 'LEADER', action = act.QuickSelect },
  -- キーボードでのスクロールバック/コピーモード起動
  { key = 'x', mods = 'LEADER', action = act.ActivateCopyMode },
  -- コマンドパレットを開く
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
}
}
