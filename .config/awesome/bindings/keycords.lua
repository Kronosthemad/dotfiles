

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local mymainmenu = require("applications")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local menubar = require("menubar")
local volume_widget = require('widgets.volume-widget.volume')
modkey = "Mod4"



-- 1. Define your Leader Key Bindings (Add as many as you want)
local leader_keys = {
    ["Leader Key"] = {
        { modifiers = {}, keys = { b = "Launch Google Chrome" } },
        { modifiers = {}, keys = { Return = "Launch Terminal" } },
        { modifiers = {}, keys = { g = "Launch Gvim" } },
        { modifiers = {}, keys = { e = "Launch Emacs" } },
        { modifiers = {}, keys = { e = "Launch Youtube" } },
        { modifiers = {}, keys = { Escape = "Cancel" } },
    }
}
local press_time = 0
-- The threshold (in seconds). 0.2 is a "quick tap"
local tap_threshold = 0.20

keycords = {
-- Leader key implementation
  awful.key({}, "Super_L", function()
      update_mode_widget("Listening")
      refresh_borders("#ffcc00")
      local help_popup = hotkeys_popup.show_help(nil, nil, { show_awesome_keys = false })

      awful.keygrabber.run(function(mod, key, event)
          if event == "release" then
              if key == "Super_L" then
                  -- Super_L released, stop grabber
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "b" then
                  awful.spawn("google-chrome-stable")
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "Return" then
                  awful.spawn(terminal or "alacritty")
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "g" then
                  awful.spawn("gvim")
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "e" then
                  awful.spawn("emacsclient -r")
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "y" then
                  awful.spawn("/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml")
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              elseif key == "Escape" then
                  help_popup:hide()
                  update_mode_widget("Corded")
                  refresh_borders("#634087")
                  awful.keygrabber.stop()
              end
          end
      end)
  end,
  {description = "leader key", group = "awesome"})
}
return keycords
-- Variable to store the time Super_L was pressed
-- This keybind initiates the logic
