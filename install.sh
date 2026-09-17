#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "================================"
echo "       Pukka-KDE Installer"
echo "================================"
echo

# Check operating system
if [ ! -f /etc/os-release ]; then
    echo "ERROR: Cannot determine the operating system."
    exit 1
fi

. /etc/os-release

if [ "${ID:-}" != "fedora" ]; then
    echo "ERROR: Pukka-KDE is designed for Fedora Linux."
    exit 1
fi

echo "Fedora detected."
echo

echo "[1/7] Installing Fedora packages..."

sudo dnf install -y \
    zsh \
    fastfetch \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    curl \
    unzip \
    konsole

echo
echo "[2/7] Installing Starship..."

if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship already installed."
fi

echo
echo "[3/7] Installing JetBrains Mono Nerd Font..."

FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMono"
FONT_ARCHIVE="/tmp/JetBrainsMono.zip"

if fc-list : family | grep -F "JetBrainsMono Nerd Font" >/dev/null 2>&1; then
    echo "JetBrains Mono Nerd Font already installed."
else
    mkdir -p "$FONT_DIR"

    curl -L \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
        -o "$FONT_ARCHIVE"

    unzip -q "$FONT_ARCHIVE" -d "$FONT_DIR"

    fc-cache -f

    rm -f "$FONT_ARCHIVE"
fi

echo
echo "[4/7] Backing up existing Zsh configuration..."

if [ -f "$HOME/.zshrc" ]; then
    BACKUP="$HOME/.zshrc.pukka-backup-$(date +%Y%m%d-%H%M%S)"
    cp "$HOME/.zshrc" "$BACKUP"
    echo "Backup created:"
    echo "$BACKUP"
fi

echo
echo "[5/7] Installing Pukka-KDE configuration..."

mkdir -p \
    "$HOME/.config/pukka-kde" \
    "$HOME/.config/fastfetch" \
    "$HOME/.local/share/konsole"

cp "$SCRIPT_DIR/zsh/zshrc" \
    "$HOME/.zshrc"

cp "$SCRIPT_DIR/zsh/animation.zsh" \
    "$HOME/.config/pukka-kde/animation.zsh"

cp "$SCRIPT_DIR/starship/starship.toml" \
    "$HOME/.config/starship.toml"

cp "$SCRIPT_DIR/fastfetch/config.jsonc" \
    "$HOME/.config/fastfetch/config.jsonc"

cp "$SCRIPT_DIR/konsole/Pukka-KDE.profile" \
    "$HOME/.local/share/konsole/Pukka-KDE.profile"

cp "$SCRIPT_DIR/konsole/Pukka-KDE.colorscheme" \
    "$HOME/.local/share/konsole/Pukka-KDE.colorscheme"

echo
echo "[6/7] Setting Zsh as login shell..."

ZSH_PATH="$(command -v zsh || true)"

if [ -z "$ZSH_PATH" ]; then
    echo "ERROR: Zsh was not found after installation."
    exit 1
fi

CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
else
    echo "Zsh is already the login shell."
fi

echo
echo "[7/7] Updating KDE configuration..."

if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 \
        --file "$HOME/.config/konsolerc" \
        --group "Desktop Entry" \
        --key DefaultProfile \
        "Pukka-KDE.profile"
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
fi

echo
echo "================================"
echo "       Installation complete"
echo "================================"
echo
echo "Close Konsole completely and open it again."
echo
