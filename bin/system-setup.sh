#!/usr/bin/env bash
sudo pacman -S tk
sudo pacman -S tcl
sudo pacman -S xorg-xrandr
sudo pacman -S plasma-x11-session
sudo pacman -S direnv
sudo pacman -S fastfetch
sudo pacman -S exa
sudo pacman -S zoxide
sudo pacman -S gvim
sudo pacman -S nano
sudo pacman -S micro
sudo pacman -S archlinux-tools
sudo pacman -S lazygit
sudo pacman -S fish
sudo pacman -S man-db
sudo pacman -S tldr
sudo pacman -S trash-cli
sudo pacman -S github-cli
sudo pacman -S rofi
sudo pacman -S tmux
curl 'https://invent.kde.org/sdk/kde-builder/-/raw/master/scripts/initial_setup.sh?ref_type=heads' > inital_setup.sh
chmod +755 inital_setup.sh
./inital_setup.sh
git config --global user.email "chemicalorca22@gmail.com"
git config --global user.name "Eli Weatherby"
