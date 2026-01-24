# dotfiles
my dotfiles with a bare repository

# Installing
In order to get it so you can have all of the files in the correct place you need to do a pull and it sets it up so you can use the aliases to work with the 
repository

``` sh
cd $HOME
git clone --depth 1 https://github.com/Kronosthemad/dotfiles
mv .bashrc .bashrc.bak
git init --bare $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME pull origin master
```

# Getting repo
If you just want to get the files to pull one or two files out of but don't care about keeping up with the bare repo you can jus run

``` sh
git clone --depth 1 https://gihub.com/Kronosthemad/dotfiles
```

# quick setup
This repo has a few dependancys for some of the convenince scripts mostly the fish functions to make it easy to get them all i have written a setup
script that sets up the system the way i use mine. 

``` sh
nano $HOME/bin/setup-system.sh
$HOME/bin/setup-system.sh
```
## the window manager
the window manager that i use is a heavily customized awesome wm and i have gone against some of the best practice for the tag management for some more granular
this is just how i take care of the number 1 and the standard arrow keys...


### my config
``` lua

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey }, "1",
                   function ()
                         local screen = awful.screen.focused()
                         if not screen then return end
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
                      if not screen then return end
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
```

### awesomes way
this is the example the t pulled from the awesome website to show how it is done and they were a bit help while i was still learning 
lua but this is how they take care of but it was causing weird effects when pinning to multiple tags to an application so i made it much more
verbose and granular so it handles the tagging how i wanted it to 
``` lua

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
-- source :   https://awesomewm.org/doc/api/sample%20files/rc.lua.html
```

