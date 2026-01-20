#!/usr/bin/env bash

# Get the names of the connected ports
HDMI_PORT=$(xrandr | grep "HDMI" | grep " connected" | awk '{print $1}')
DVI_PORT=$(xrandr | grep "DVI" | grep " connected" | awk '{print $1}')


xrandr --output "$DVI_PORT" --left-of "$HDMI_PORT"
xrandr --output "$DVI_PORT" --primary
xrandr --output "$HDMI_PORT" --mode 1920x1080 --rate 60.00
