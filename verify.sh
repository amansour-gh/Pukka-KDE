#!/usr/bin/env bash

set -u

PASS=0
FAIL=0

check() {
    local description="$1"
    shift

    if "$@"; then
        printf 'PASS: %s\n' "$description"
        PASS=$((PASS + 1))
    else
        printf 'FAIL: %s\n' "$description"
        FAIL=$((FAIL + 1))
    fi
}

echo "================================"
echo "       Pukka-KDE Verify"
echo "================================"
echo

echo "Checking commands..."
check "Zsh is installed" command -v zsh
check "Starship is installed" command -v starship
check "Fastfetch is installed" command -v fastfetch
check "Konsole is installed" command -v konsole

echo
echo "Checking Zsh dependencies..."
check "zsh-autosuggestions is installed" \
    test -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

check "zsh-syntax-highlighting is installed" \
    test -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo
echo "Checking shell..."

ZSH_PATH="$(command -v zsh 2>/dev/null || true)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

check "Zsh is available" test -n "$ZSH_PATH"
check "Configured login shell matches Zsh" test "$CURRENT_SHELL" = "$ZSH_PATH"

echo
echo "Checking fonts..."
check "JetBrains Mono Nerd Font is installed" \
    bash -c 'fc-list : family 2>/dev/null | grep -Fq "JetBrainsMono Nerd Font"'

echo
echo "Checking Pukka-KDE files..."
check "Zsh configuration installed" \
    test -f "$HOME/.zshrc"

check "Startup animation installed" \
    test -f "$HOME/.config/pukka-kde/animation.zsh"

check "Starship configuration installed" \
    test -f "$HOME/.config/starship.toml"

check "Fastfetch configuration installed" \
    test -f "$HOME/.config/fastfetch/config.jsonc"

check "Konsole profile installed" \
    test -f "$HOME/.local/share/konsole/Pukka-KDE.profile"

check "Konsole color scheme installed" \
    test -f "$HOME/.local/share/konsole/Pukka-KDE.colorscheme"

echo
echo "Checking Konsole configuration..."

DEFAULT_PROFILE="$(kreadconfig6 \
    --file "$HOME/.config/konsolerc" \
    --group "Desktop Entry" \
    --key DefaultProfile 2>/dev/null || true)"

check "Pukka-KDE is the default Konsole profile" \
    test "$DEFAULT_PROFILE" = "Pukka-KDE.profile"

COLOR_SCHEME="$(grep '^ColorScheme=' \
    "$HOME/.local/share/konsole/Pukka-KDE.profile" 2>/dev/null || true)"

check "Pukka-KDE profile uses the Pukka-KDE color scheme" \
    test "$COLOR_SCHEME" = "ColorScheme=Pukka-KDE"

echo
echo "================================"
printf 'Passed: %d\n' "$PASS"
printf 'Failed: %d\n' "$FAIL"
echo "================================"

if [ "$FAIL" -eq 0 ]; then
    exit 0
else
    exit 1
fi
