#!/usr/bin/env bash

#!/bin/bash

# --- 1. Load OS Identity ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "Error: /etc/os-release not found. Cannot determine OS."
    exit 1
fi

# --- 2. Define the Detection Logic ---
# We use a case statement based on ID/ID_LIKE,
# but we verify the tool exists before committing to it.

detect_package_manager() {
    # Check ID and ID_LIKE to narrow down the family
    case "$ID $ID_LIKE" in
        *ubuntu*|*debian*|*mint*|*kali*)
            if command -v apt &> /dev/null; then
                PM="apt"
                INSTALL_CMD="apt install -y"
                UPDATE_CMD="apt update"
            fi
            ;;
        *fedora*|*rhel*|*centos*|*rocky*|*almalinux*)
            if command -v dnf &> /dev/null; then
                PM="dnf"
                INSTALL_CMD="dnf install -y"
                UPDATE_CMD="dnf check-update"
            elif command -v yum &> /dev/null; then
                PM="yum"
                INSTALL_CMD="yum install -y"
                UPDATE_CMD="yum check-update"
            fi
            ;;
        *arch*|*manjaro*)
            if command -v pacman &> /dev/null; then
                PM="pacman"
                INSTALL_CMD="pacman -S --noconfirm"
                UPDATE_CMD="pacman -Sy"
            fi
            ;;
        *alpine*)
            if command -v apk &> /dev/null; then
                PM="apk"
                INSTALL_CMD="apk add"
                UPDATE_CMD="apk update"
            fi
            ;;
        *suse*)
            if command -v zypper &> /dev/null; then
                PM="zypper"
                INSTALL_CMD="zypper install -y"
                UPDATE_CMD="zypper refresh"
            fi
            ;;
    esac

    # --- 3. Final Fallback ---
    # If the OS identity didn't help, try a blind "last ditch" search
    if [ -z "$PM" ]; then
        if command -v apt &> /dev/null; then PM="apt"; INSTALL_CMD="apt install -y";
        elif command -v dnf &> /dev/null; then PM="dnf"; INSTALL_CMD="dnf install -y";
        elif command -v pacman &> /dev/null; then PM="pacman"; INSTALL_CMD="pacman -S --noconfirm";
        else
            echo "Error: Could not identify a supported package manager."
            exit 1
        fi
    fi
}

# Run the detection
detect_package_manager

# --- 4. Usage Example ---
echo "Detected: $PM"
echo "Running update..."
sudo $UPDATE_CMD

echo "Installing git..."
sudo $INSTALL_CMD git
echo "installing tk..."
sudo $INSTALL_CMD tk
echo "Installing tcl..."
sudo $INSTALL_CMD tcl
echo "Installing xorg-xrandr..."
sudo $INSTALL_CMD xorg-xrandr
echo "Installing plasma-x11-session..."
sudo $INSTALL_CMD plasma-x11-session
echo "Installing direnv..."
sudo $INSTALL_CMD direnv
echo "Installing fastfetch..."
sudo $INSTALL_CMD fastfetch
echo "Installing exa..."
sudo $INSTALL_CMD exa
echo "Installing zoxide..."
sudo $INSTALL_CMD zoxide
echo "Installing gvim..."
sudo $INSTALL_CMD gvim
echo "Installing nano..."
sudo $INSTALL_CMD nano
echo "Installing micro..."
sudo $INSTALL_CMD micro
echo "Installing emacs..."
sudo $INSTALL_CMD emacs
echo "Installing archlinux-tools..."
sudo $INSTALL_CMD archlinux-tools
echo "Installing lazygit..."
sudo $INSTALL_CMD lazygit
echo "Installing fish..."
sudo $INSTALL_CMD fish
echo "Installing man-db..."
sudo $INSTALL_CMD man-db
echo "Installing tldr..."
sudo $INSTALL_CMD tldr
echo "Installing trash-cli..."
sudo $INSTALL_CMD trash-cli
echo "Installing github-cli..."
sudo $INSTALL_CMD github-cli
echo "Installing rofi..."
sudo $INSTALL_CMD rofi
echo "Installing tmux..."
sudo $INSTALL_CMD tmux
echo "Installing alacritty..."
sudo $INSTALL_CMD alacritty


# Capital 'Y' signals it is the default
read -rp "Do you want to setup kde-builder? [y/N]: " choice

# Use a default value if 'choice' is empty
choice="${choice:-n}"

case "$choice" in
    [yY][eE][sS]|[yY])
        echo "Setting up kde-builder"
        curl 'https://invent.kde.org/sdk/kde-builder/-/raw/master/scripts/initial_setup.sh?ref_type=heads' > inital_setup.sh
        chmod +755 inital_setup.sh
        ./inital_setup.sh
        ;;
    [nN][oO]|[nN])
        echo "Skipping kde-builder setup."
        ;;
    *)
        echo "Invalid input, skipping by default."
        ;;
esac

#!/bin/bash

# Capital 'Y' signals it is the default
read -rp "Do you want to use doom-emacs on the system? [Y/n]: " choice

# Use a default value if 'choice' is empty
choice="${choice:-y}"

case "$choice" in
    [yY][eE][sS]|[yY])
        echo "setting up doom-emacs"
        git clone --depth 1 https://github.com/Kronosthemad/doomemacs ~/.config/emacs
        ~/.config/emacs/bin/doom install
        ;;
    [nN][oO]|[nN])
        echo "Skipping setting up doom-emacs."
        ;;
    *)
        echo "Invalid input, setting up doom-emacs by default."
        ;;
esac



read -rp "Do you want to setup git with your info? [Y/n]" choice

case "$choice" in
    [Yy][eE][sS]|[Yy])
        read -rp "email:" EMAIL
        git config --global user.email $EMAIL
        read -rp "name:" NAME
        git config --global usr.name $NAME
        ;;
    [nN][oO]|[nN])
        echo "skipping setup"
        ;;
    [mM])
        echo "setting up git for commiting"
        git config --global user.email "chemicalorca22@gmail.com"
        git config --global user.name "Eli Weatherby"
        ;;
    *)
        echo "Invalid input"
esac
