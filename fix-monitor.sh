#!/usr/bin/env bash

xrandr --output DVI-0 --primary

xrandr --output DVI-0 --left-of HDMI-0

xrandr --output DVI-0 --rotate left

xrandr --output HDMI-0 --auto

echo "fixed monitors?"
