local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local gears = require("gears")
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")



chromeapps = {
	{ "Youtube", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml", beautiful.awesome_icon },
	{ "Github", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg", beautiful.awesome_icon }
}

shellmenu = {
	{ "Fish", terminal .. " -e /usr/bin/fish", beautiful.awesome_icon },
	{ "Bash", terminal .. " -e /usr/bin/bash", beautiful.awesome_icon },
	{ "Powershell", terminal .. " -e /usr/bin/pwsh", beautiful.awesome_icon },
	{ "Nushell", terminal .. " -e /usr/bin/nu", beautiful.awesome_icon }
}

utilityapps = {
	{ "Nitrogen", "nitrogen", beautiful.awesome_icon },
	{ "Boxes", "gnome-boxes", beautiful.awesome_icon },
	{ "Linutil", terminal .. " -e linutil", beautiful.awesome_icon }
}

internetapps = {
	{ "Google Chrome", "google-chrome-stable", beautiful.awesome_icon },
	{ "Chrome Apps", chromeapps, beautiful.awesome_icon }
}

langsmenu = {
	{ "Python", terminal .. " -e python3", beautiful.awesome_icon },
	{ "Lua", terminal .. " -e lua", beautiful.awesome_icon }
}

mediaapps = {
	{ "Kdenlive", "kdenlive", beautiful.awesome_icon },
	{ "Obs-studio", "obs", beautiful.awesome_icon },
	{ "Qasmixer", "qasmixer", beautiful.awesome_icon },
	{ "QasConfig", "qasconfig", beautiful.awesome_icon },
	{ "Helvum", "helvum", beautiful.awesome_icon },
	{ "Wiremix", terminal .. " -e wiremix", beautiful.awesome_icon }
}

systemapps = {
	{ "Pcmanfm", "pcmanfm", beautiful.awesome_icon },
	{ "Alacritty", "alacritty", beautiful.awesome_icon },
	{ "Xterm", "xterm -rv", beautiful.awesome_icon },
	{ "Rofi", "rofi -show", beautiful.awesome_icon },
	{ "Shells", shellmenu, beautiful.awesome_icon }
}

gamemenu = {
	{ "2048", "gnome-2048", beautiful.awesome_icon },
	{ "Chess", "gnome-chess", beautiful.awesome_icon },
	{ "Mahjongg", "gnome-mahjongg", beautiful.awesome_icon },
	{ "Mines", "gnome-mines", beautiful.awesome_icon }
}

developmentapps = {
	{ "Gvim", "gvim", beautiful.awesome_icon },
	{ "Cmake", "cmake-gui", beautiful.awesome_icon },
	{ "Languages", langsmenu, beautiful.awesome_icon }
}

appmenu = {
	{ "Development", developmentapps, beautiful.awesome_icon },
	{ "Game", gamemenu, beautiful.awesome_icon },
	{ "Internet", internetapps, beautiful.awesome_icon },
	{ "Media", mediaapps, beautiful.awesome_icon },
	{ "System", systemapps, beautiful.awesome_icon },
	{ "Utility", utilityapps, beautiful.awesome_icon }
}

myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, beautiful.awesome_icon },
   { "Manual", terminal .. " -e man awesome", beautiful.awesome_icon },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile, beautiful.awesome_icon },
   { "Restart", awesome.restart, beautiful.awesome_icon },
   { "Quit", function() awesome.quit() end, beautiful.awesome_icon },
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
				    { "Applications", appmenu, beautiful.awesome_icon },
                                    { "Open Terminal", terminal, beautiful.awesome_icon }
                                  }
                        })


return mymainmenu
