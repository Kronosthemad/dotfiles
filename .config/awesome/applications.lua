local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local gears = require("gears")
local xdgmenu = require("index")
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "emacsclient -r"
editor_cmd = terminal .. " -e " .. editor
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
beautiful.init(gears.filesystem.get_configuration_dir() .. "zenburn/theme.lua")

function updatemenu ()
	awful.spawn("alacritty -se 'xdg_menu --format awesome > /home/kronos/.config/awesome/menu.lua'" )
	awful.spawn("alacritty -se echo 'return xdgmenu' >> /home/kronos/.config/awesome/menu.lua")
	awesome.restart()
end

myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, beautiful.awesome_icon },
   { "Manual", terminal .. " -e man awesome", beautiful.awesome_icon },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile, beautiful.awesome_icon },
   { "Restart Awesome", function() awesome.restart() end, beautiful.awssome_icon },
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
				    { "Applications", xdgmenu, beautiful.awesome_icon },
                                    { "Open Terminal", terminal, beautiful.awesome_icon },
				    { "Update Menu", updatemenu, beautiful.awsome_icon }
                                  }
                        })


return mymainmenu
 
