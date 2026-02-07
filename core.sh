#!/bin/bash
set -euo pipefail

# Update system repositories
sudo pacman -Syu --noconfirm

# Core System
CORE_SYSTEM=(
  i3-wm
  i3status
  i3lock
  xss-lock
  xdg-user-dirs
  xdg-utils
  dbus
  lxqt-policykit
  xorg-xinit
  xorg-server
  xorg-xrandr
  base-devel
  ca-certificates
  python
  git
  dunst
  libnotify
  mesa
)

# Essential CLI Tools
CLI_TOOLS=(
  which
  bash-completion
  zip
  unzip
  rsync
  wget
  curl
  htop
  xclip
)

# Core User Tools
USER_TOOLS=(
  rofi
  imv
  scrot
  xterm
  alacritty
)

# Audio & Brightness
AUDIO_BRIGHTNESS=(
  pipewire
  pipewire-pulse
  pipewire-alsa
  wireplumber
  pavucontrol
  pamixer
  brightnessctl
)

# Essential Desktop Applications
DESKTOP_APPS=(
  chromium
  firefox
  pcmanfm
  gvfs
  udiskie
)

# Hardware Utilities
HARDWARE_UTILS=(
  usbutils
  dmidecode
  pciutils
)

# Fonts
FONTS=(
  ttf-liberation
  ttf-dejavu
  ttf-jetbrains-mono
)

# Development Tools
DEV_TOOLS=(
  direnv
  ripgrep
  neovim
  jq
)

# Installation process
sudo pacman -S --needed --noconfirm \
  "${CORE_SYSTEM[@]}" \
  "${CLI_TOOLS[@]}" \
  "${USER_TOOLS[@]}" \
  "${AUDIO_BRIGHTNESS[@]}" \
  "${DESKTOP_APPS[@]}" \
  "${HARDWARE_UTILS[@]}" \
  "${FONTS[@]}" \
  "${DEV_TOOLS[@]}"


# --- Post-installation configuration ---

echo "Creating symbolic links for configuration files..."

# Get the absolute path of the current directory
REPO_PATH=$(pwd)

# 1. Home configurations (bashrc, xinitrc)
# Using -f to force/overwrite existing files
ln -sf "$REPO_PATH/home-config/bashrc" "$HOME/.bashrc"
ln -sf "$REPO_PATH/home-config/xinitrc" "$HOME/.xinitrc"

# 2. Ensure XDG Config directories exist
mkdir -p ~/.config/i3
mkdir -p ~/.config/alacritty

# 3. Create symbolic links for app configs
if [ -f "$REPO_PATH/i3/config" ]; then
    ln -sf "$REPO_PATH/i3/config" "$HOME/.config/i3/config"
    echo "Linked: i3 config"
fi

if [ -f "$REPO_PATH/alacritty/alacritty.toml" ]; then
    ln -sf "$REPO_PATH/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
    echo "Linked: Alacritty config"
fi

# 4. Set correct permissions for xinitrc
chmod +x "$HOME/.xinitrc"

# 5. Update user directories (Documents, Downloads, etc.)
command -v xdg-user-dirs-update >/dev/null && xdg-user-dirs-update

# 6. Enable Audio Services (Pipewire)
echo "Enabling Pipewire services..."
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service

echo "--------------------------------------------------"
echo "Setup complete! Configs are now linked to this repo."
echo "You can now run 'startx' to launch your environment."
echo "--------------------------------------------------"

sleep 10
sudo reboot
