
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

keybinds = {-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({ modkey            }, "b",     function () awful.spawn("google-chrome-stable") end,
    	      {description = "launch browser", group = "launcher"}),
    awful.key({ modkey            }, "y",     function () awful.spawn("/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml") end,
    	      {description = "launch youtube", group = "launcher"}),
    awful.key({                   }, "F12",   function () awful.spawn.with_shell("qdbus org.kde.yakuake /yakuake/MainWindow_1 toggleWindowState") end,
	      {description = "toggle yakuake", group = "launcher"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",    function () awful.spawn("rofi -show drun") end, 
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey },             "v",     function() awful.spawn("code") end,
    	      { description = "Launch VScode", group = "launcher" }), 
    awful.key({ modkey },             "g",     function() awful.spawn("gvim") end,
    	      { description = "Launch Gvim",   group = "launcher" }),

    awful.key({ modkey },             "e",     function () awful.spawn("emacsclient -r") end,
              { description = "Launch Emacs",  group = "launcher" }),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
        -- View tag only.
        awful.key({ modkey }, "1",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[1]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #1", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "1",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[1]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #1", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "1",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[1]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #1", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "1",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[1]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #1", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "2",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[2]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #2", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "2",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[2]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #2", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "2",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[2]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #2", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "2",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[2]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #2", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "3",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[3]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #3", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "3",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[3]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #3", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "3",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[3]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #3", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "3",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[3]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #3", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "4",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[4]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #4", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "4",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[4]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #4", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "4",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[4]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #4", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "4",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[4]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #4", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "5",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[5]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #5", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "5",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[5]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #5", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "5",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[5]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #5", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "5",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[5]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #5", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "6",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[6]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #6", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "6",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[6]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #6", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "6",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[6]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #6", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "6",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[6]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #6", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "7",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[7]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #7", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "7",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[7]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #7", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "7",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[7]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #7", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "7",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[7]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #7", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "8",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[8]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #8", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "8",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[8]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #8", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "8",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[8]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #8", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "8",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[8]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #8", group = "tag"}),
        -- View tag only.
        awful.key({ modkey }, "9",
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[9]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #9", group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "9",
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[9]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #9", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "9",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[9]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag 9", group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "9",
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[9]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #9", group = "tag"}),
    
-- Add binding for Tag "0" (which is the 10th tag, so index [10])
    -- View tag "0" (index 10)
    awful.key({ modkey }, "0",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[10]
                    if tag then
                       tag:view_only()
                    end
              end,
              {description = "view tag #0", group = "tag"}),
    -- Toggle tag display "0" (index 10)
    awful.key({ modkey, "Control" }, "0",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[10]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end,
              {description = "toggle tag #0", group = "tag"}),
    -- Move client to tag "0" (index 10)
    awful.key({ modkey, "Shift" }, "0",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[10]
                      if tag then
                          client.focus:move_to_tag(tag)
                      end
                  end
              end,
              {description = "move focused client to tag #0", group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "0",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[10]
                      if tag then
                          client.focus:toggle_tag(tag)
                      end
                  end
              end,
              {description = "toggle focused client on tag #0", group = "tag"}),
	awful.key({ modkey }, "]", function() volume_widget:inc() end,
		  { description = "Volume up", group = "Widget" }),
	awful.key({ modkey }, "[", function() volume_widget:dec() end,
	 	  {description = "Volume Down", group = "Widget"}),
	awful.key({ modkey }, "\\", function() volume_widget:toggle() end,
	  	  { description = "Mute Volume", group = "Widget" })
	  ),


clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)
}



return keybinds
