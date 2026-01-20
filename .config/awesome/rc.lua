-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

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
local cpu_widget = require("widgets.cpu-widget.cpu-widget")
local volume_widget = require('widgets.volume-widget.volume')
local calendar_widget = require("widgets.calendar-widget.calendar")
local ram_widget = require("widgets.ram-widget.ram-widget")
local pacman_widget = require('widgets.pacman-widget.pacman')
local fs_widget = require("widgets.fs-widget.fs-widget")
local logout_menu_widget = require("widgets.logout-menu-widget.logout-menu")
local standard_keys = require("bindings.keybinds")
local corded_keys = require("bindings.keycords")
local shared_keys = require("bindings.keyshared")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors,
		     icon = "/usr/share/icons/Pop/scalable/status/dialog-error-symbolic.svg"
	     })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        if string.find(tostring(err), 'bad argument #2 to "format"') then
            return -- Exit the function without showing a notification
        end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, you messed up something, an error happened!",
                         text = tostring(err),
			 icon = "/usr/share/icons/Pop/scalable/status/dialog-warning-symbolic.svg"
		 })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/zenburn/theme.lua")
beautiful.useless_gap = 4
beautiful.border_width = 4
beautiful.border_normal = "#d02518"
beautiful.border_focus = "#634087"



function refresh_borders(color)
    beautiful.border_focus = color
    for _, c in ipairs(client.get()) do
        if c == client.focus then
            c.border_color = color
        end
    end
end


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Default terminal
terminal = "alacritty"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
   -- awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
   -- awful.layout.suit.fair,
   -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max,
   -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })


-- Menubar configuration
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s) awful.spawn("xwallpaper --zoom /usr/share/wallpapers/Path/contents/images/1920x1080.jpg --output DVI-0 --output HDMI-0") end



-- Set keys
local current_mode = "standard"
-- Combine them into one flat table first
local all_standard_keys = {}

function apply_keys(source_tables)
    local master_table = {}

    for _, key_table in ipairs(source_tables) do
        if type(key_table) == "table" then
            for _, key_obj in ipairs(key_table) do
                table.insert(master_table, key_obj)
            end
        end
    end

    if #master_table > 0 then
        -- Use table.unpack for Lua 5.2/5.3 compatibility
        local status, result = pcall(function()
            root.keys(gears.table.join(table.unpack(master_table)))
        end)

        if not status then
            naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Keybind Error",
                text = "Failed to apply keys: " .. tostring(result)
            })
        end
    end
end
-- We pass an array of our key tables
apply_keys({ standard_keys, shared_keys })
mode_widget = wibox.widget.textbox()
mode_widget.text = "Mode: [Standard]"

function update_mode_widget(state)
    local text = ""
    local color = "#ffffff"
    current_state = state
    local border_color = "#634087"


    if state == "Listening" then
        text = "Mode: [ Listening. ] "
        color = "#ffcc00" -- Gold/Yellow
        border_color = "#ffcc00"
    elseif state == "Corded" then
        text = "Mode: [ Corded ] "
        color = "#ff0000" -- Red
    else
        text = "Mode: [ Standard ] "
        color = "#00ff00" -- Green
    end

    mode_widget.markup = "<span font='bold' foreground='" .. color .. "'>" .. text .. "</span>"

   end

function toggle_key_mode()
    local new_keys -- Clear all existing global keys
    local target

    if current_mode == "standard" then
        naughty.notify({ title = "Mode Switching", text = "Using KEYCORD Mode (Leader: Mod4)" })
        target = "Corded"
        apply_keys({ corded_keys, shared_keys })
        update_mode_widget("Corded")
    else
        naughty.notify({ title = "Mode Switching", text = "Using STANDARD Mode" })
        target = "Standard"
        apply_keys({ standard_keys, shared_keys })
        update_mode_widget("Standard")
    end
-- Update logic
    current_mode = target

    -- Capitalize for the widget function
    local display_state = target:gsub("^%l", string.upper)
    update_mode_widget(display_state)

     if current_mode:lower() ~= current_state:lower() then
         update_mode_widget(current_mode)
         refresh_borders("#634087")
     end
    root.keys(new_keys)
    naughty.notify({
        title = "Mode Switched",
        text = "Now in " .. current_mode:upper() .. " mode"
    })
end


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    local tagname = { "1.main", "2.terminal", "3.refrence", "4.audio", "5.filemanager", "6.web", "7.virtulization", "8.sysmonitor", "9.misc", "0.etc" }
    -- Each screen has its own tag table.
    awful.tag(tagname, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        bg = "#634087"
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            logout_menu_widget(),
            s.mytaglist,
	    cpu_widget(),
	    ram_widget(),
            fs_widget({ mounts = { '/', '/home' } }), 
	    {
	  	layout = awful.widget.only_on_screen,
		screen = "primary",
	    	mode_widget,
    	    },
	    s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    {
		layout = awful.widget.only_on_screen,
		screen = "primary",
            	mykeyboardlayout,
            	wibox.widget.systray(),
		volume_widget{
			wiget_type = "horizontal_bar"
		 },
        pacman_widget {
            interval = 600, -- Refresh every 10 minutes
            popup_bg_color = '#222222',
            popup_border_width = 1,
            popup_border_color = '#7e7e7e',
            popup_height = 10,  -- 10 packages shown in scrollable window
            popup_width = 300,
            polkit_agent_path = '/usr/bin/lxpolkit'
        },
       	  },
	    mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


local cw = calendar_widget({
    theme = 'outrun',
    placement = 'top_right',
    start_sunday = true,
    radius = 8,
-- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3
})


clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = client_keys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "tk",
  	  "Tk"},


        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
    {rule_any = {
    id         = "yakuake",
    rule       = { class = "yakuake" },
    properties = {
        floating = true,
        sticky   = true,
        ontop    = true,
        border_width = 0,
    } 
  } 

 }
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
  -- Client keys






client_keys = gears.table.join({
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
        {description = "(un)maximize horizontally", group = "client"}),
})

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
awful.spawn.with_shell("picom")
awful.spawn.with_shell("yakuake")
awful.spawn.with_shell("emacs --daemon")
awful.spawn.with_shell("/home/kronos//bin/fix-display.sh")
