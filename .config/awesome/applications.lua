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
beautiful.init(gears.filesystem.get_configuration_dir() .. "zenburn/theme.lua")


chromeapps = {
	{ "Youtube", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml", beautiful.awesome_icon },
	{ "Github", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg", beautiful.awesome_icon },
	{ "Github Docs", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=hdgllcpmkphgagldcgmpkghcmaklnbai", beautiful.awesome_icon },
	{ "Google Docs", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=aohghmighlieiainnegkcijnfilokake", beautiful.awesome_icon },
	{ "Google Sheets", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=felcaaldnbdncclmgdcncolpebgiejap", beautiful.awesome_icon },
	{ "Google Slides", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=boadgeojelhgndaghljhdicfkmllpafd", beautiful.awesome_icon },
	{ "Google Calendar", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=ejjicmeblgpmajnghnpcppodonldlgfn", beautiful.awesome_icon },
	{ "Google Drive", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=aghbiahbpaijignceidepookljebhfak", beautiful.awesome_icon },
	{ "Youtube Music", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=cinhimbnkkaeohfgghhklpknlkffjgod", beautiful.awesome_icon },
	{ "Google Developer", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=mhjfbmdgcfjbbpaeojofohoefgiehjai", beautiful.awesome_icon },
	{ "Google Tasks", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=ejjicmeblgpmajnghnpcppodonldlgfn", beautiful.awesome_icon },
	{ "Google Keep", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=hmjkmjkepdijhoojdojkdfohbdgmmhki", beautiful.awesome_icon },
	{ "Chrome Remote Desktop", "/opt/google/chrome/google-chrome --profile-directory=Default --app-id=nolnjjmnngadpklecpnddfebfphgpgdi", beautiful.awesome_icon }
}

shellmenu = {
	{ "Fish", terminal .. " -e /usr/bin/fish", beautiful.awesome_icon },
	{ "Bash", terminal .. " -e /usr/bin/bash", beautiful.awesome_icon },
	{ "Powershell", terminal .. " -e /usr/bin/pwsh", beautiful.awesome_icon },
	{ "Nushell", terminal .. " -e /usr/bin/nu", beautiful.awesome_icon }
}

utilityapps = {
	{ "Nitrogen", "nitrogen", beautiful.awesome_icon },
	{ "Boxes", "gnome-boxes", "/usr/share/icons/hicolor/scalable/apps/org.gnome.Boxes.svg" },
	{ "Virtual Machine Manager", "virt-manager", beautiful.Awesome_icon },
	{ "Linutil", terminal .. " -e linutil", beautiful.awesome_icon },
	{ "Warehouse", "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=warehouse --file-forwarding io.github.flattool.Warehouse @@ %F @@", beautiful.awesome_icon },
	{ "Mission Center", "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=missioncenter io.missioncenter.MissionCenter", beautiful.awesome_icon }
}

internetapps = {
	{ "Google Chrome", "google-chrome-stable", beautiful.awesome_icon },
	{ "Chrome Apps", chromeapps, beautiful.awesome_icon }
}

langsmenu = {
	{ "Python", terminal .. " -e python3", beautiful.awesome_icon },
	{ "Lua", terminal .. " -e lua", beautiful.awesome_icon },
	{ "Ruby", terminal .. " -e irb", beautiful.awesome_icon },
	{ "Nodejs", terminal .. " -e node", beautiful.awesome_icon }
}

mediaapps = {
	{ "Kdenlive", "kdenlive", "/usr/share/icons/hicolor/scalable/apps/kdenlive.svg" },
	{ "Obs-studio", "obs", "/usr/share/icons/hicolor/scalable/apps/com.obsproject.Studio.svg" },
	{ "Qasmixer", "qasmixer", "/usr/share/icons/hicolor/scalable/apps/qasmixer.svg" },
	{ "QasConfig", "qasconfig", "/usr/share/icons/hicolor/scalable/apps/qasconfig.svg" },
	{ "Helvum", "helvum", "/usr/share/icons/hicolor/scalable/apps/org.pipewre.Helvum.svg" },
	{ "Wiremix", terminal .. " -e wiremix", beautiful.awesome_icon }
}

officeapps = {
	{ "LibreOffice", "libreoffice", "/usr/share/icons/hicolor/scalable/apps/libreoffice-main.svg" },
	{ "LibreOffice Base", "libreoffice --base", "/usr/share/icons/hicolor/scalable/apps/libreoffice-base.svg" },
	{ "LibreOffice Base", "libreoffice --calc", "/usr/share/icons/hicolor/scalable/apps/libreoffice-calc.svg" },
	{ "LibreOffice Base", "libreoffice --draw", "/usr/share/icons/hicolor/scalable/apps/libreoffice-draw.svg" },
	{ "LibreOffice Base", "libreoffice --impress", "/usr/share/icons/hicolor/scalable/apps/libreoffice-impress.svg" },
	{ "LibreOffice Base", "libreoffice --math", "/usr/share/icons/hicolor/scalable/apps/libreoffice-math.svg" },
	{ "LibreOffice Base", "libreoffice --writer", "/usr/share/icons/hicolor/scalable/apps/libreoffice-writer.svg" }
}
systemapps = {
	{ "Pcmanfm", "pcmanfm", beautiful.awesome_icon },
	{ "Alacritty", "alacritty", beautiful.awesome_icon },
	{ "App Editor", "/app/bin/appeditor-wrapper", beautiful.awsome_icon },
	{ "Xterm", "xterm -rv", beautiful.awesome_icon },
	{ "Btop", terminal .. " -e btop", beautiful.awesome_icon },
	{ "Rofi", "rofi -show", beautiful.awesome_icon },
	{ "Shells", shellmenu, beautiful.awesome_icon }
}

gamemenu = {
	{ "2048", "gnome-2048", "/usr/share/icons/hicolor/scalable/apps/org.gnome.TwentyFortyEight.svg" },
	{ "Chess", "gnome-chess", "/usr/share/icons/hicolor/scalable/apps/org.gnome.Chess.svg" },
	{ "Mahjongg", "gnome-mahjongg", "/usr/share/icons/hicolor/scalable/apps/org.gnome.Mahjongg.svg" },
	{ "Morrowind", "steam steam://rungameid/22320", beautiful.awesome_icon },
	{ "Mines", "gnome-mines", "/usr/share/icons/hicolor/scalable/apps/org.gnome.Mines.svg" }
}

developmentapps = {
	{ "Gvim", "gvim", beautiful.awesome_icon },
	{ "Visual Studio Code", "code", beautiful.awesome_icon },
	{ "Cmake", "cmake-gui", beautiful.awesome_icon },
	{ "Languages", langsmenu, beautiful.awesome_icon }
}

appmenu = {
	{ "Development", developmentapps, beautiful.awesome_icon },
	{ "Game", gamemenu, beautiful.awesome_icon },
	{ "Internet", internetapps, beautiful.awesome_icon },
	{ "Media", mediaapps, beautiful.awesome_icon },
	{ "Office", officeapps, beautiful.awesome_icon },
	{ "System", systemapps, beautiful.awesome_icon },
	{ "Utility", utilityapps, beautiful.awesome_icon }
}

myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, beautiful.awesome_icon },
   { "Manual", terminal .. " -e man awesome", beautiful.awesome_icon },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile, beautiful.awesome_icon },
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
				    { "Applications", appmenu, beautiful.awesome_icon },
                                    { "Open Terminal", terminal, beautiful.awesome_icon }
                                  }
                        })


return mymainmenu
