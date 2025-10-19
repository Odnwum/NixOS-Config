#!/usr/bin/env bash

# initializing wallpaper daemon 
#swww init & 
#switched to hyprpaper 
hyprpaper &
# setting wallpaper 

# set up network manager 
nm-applet --indicator & 

# the bor 
waybar &

# dunst 
dunst

# mako
mako
