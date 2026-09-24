local wezterm = require('wezterm')
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = 'Disabled'

-- WSL Ubuntuをデフォルトドメインとして設定
config.default_domain = 'WSL:Ubuntu'

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
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

return config
