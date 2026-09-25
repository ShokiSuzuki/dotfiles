local wezterm = require('wezterm')
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = 'Disabled'

-- 1. WSL Ubuntu が利用可能かチェック
local has_wsl_ubuntu = false
for _, domain in ipairs(wezterm.default_wsl_domains()) do
  if domain.name == 'WSL:Ubuntu' then
    has_wsl_ubuntu = true
    break
  end
end

-- 2. 優先度順（WSL Ubuntu -> PowerShell -> cmd）に判定してデフォルトシェルを設定
if has_wsl_ubuntu then
  config.default_domain = 'WSL:Ubuntu'
elseif wezterm.target_triple:find('windows') then
  -- Windows環境でPowerShell (pwsh.exe または powershell.exe) の存在確認
  local pwsh = wezterm.find_program('pwsh.exe') or wezterm.find_program('powershell.exe')

  if pwsh then
    config.default_prog = { pwsh }
  else
    -- PowerShellもなければコマンドプロンプトを使用
    config.default_prog = { 'cmd.exe' }
  end
end

config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true
--config.window_background_opacity = 1.0
config.macos_window_background_blur = 20

------------------------------------------------------
-- Color Scheme
--------------------------------------------------------
---
config.color_scheme = 'OneHalfDark'

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#5c6d74"
   local foreground = "#FFFFFF"

   if tab.is_active then
     background = "#ae8b2d"
     foreground = "#FFFFFF"
   end

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
   }
end)

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示
-- config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = false
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = true
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = true

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
  split = '#bbbbbb',
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.4,
}

----------------------------------------------------
-- window
----------------------------------------------------
-- デフォルトのウィンドウサイズを指定（列数 x 行数）
config.initial_cols = 120 -- 横方向の文字数（列）
config.initial_rows = 35  -- 縦方向の行数

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

return config
