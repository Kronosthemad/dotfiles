
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
modkey = "Mod4"

keybinds = {-- {{{ Key bindings

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey            }, "b",     function () awful.spawn("google-chrome-stable") end,
    	      {description = "launch browser", group = "launcher"}),
    awful.key({ modkey            }, "y",     function () awful.spawn("/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml") end,
    	      {description = "launch youtube", group = "launcher"}),

   awful.key({ modkey },             "v",     function() awful.spawn("code") end,
    	      { description = "Launch VScode", group = "launcher" }), 
    awful.key({ modkey },             "g",     function() awful.spawn("gvim") end,
    	      { description = "Launch Gvim",   group = "launcher" }),

    awful.key({ modkey },             "e",     function () awful.spawn("emacsclient -r") end,
              { description = "Launch Emacs",  group = "launcher" })
}



return keybinds
