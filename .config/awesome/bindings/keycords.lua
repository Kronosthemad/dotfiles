

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



-- Define your Leader Key Bindings
local leader_actions = {
    b = function() awful.spawn("google-chrome-stable") end,
    Return = function() awful.spawn(terminal or "alacritty") end,
    g = function() awful.spawn("gvim") end,
    e = function() awful.spawn("emacsclient -r") end,
    y = function() awful.spawn("/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml") end,
    Escape = function() end,  -- Cancel, do nothing
}

keycords = {
-- Leader key implementation
  awful.key({}, "F1", function()
      awful.keygrabber.run(function(mod, key, event)
          if event == "press" then
              local action = leader_actions[key]
              if action then
                  action()
              end
              awful.keygrabber.stop()
          end
      end)
  end,
  {description = "leader key", group = "awesome"})
}
return keycords
