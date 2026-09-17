# Pukka-KDE Manual Installation

This guide explains how to install the Pukka-KDE environment manually instead of running `install.sh`.

## Requirements

Pukka-KDE is designed primarily for Fedora KDE Plasma.

Required packages:

* Zsh
* Fastfetch
* zsh-autosuggestions
* zsh-syntax-highlighting
* curl
* unzip
* Konsole
* JetBrains Mono Nerd Font

Install the Fedora packages:

```bash
sudo dnf install -y \
    zsh \
    fastfetch \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    curl \
    unzip \
    konsole
```

## Install Starship

Install Starship using the official installer:

```bash
curl -sS https://starship.rs/install.sh | sh
```

Verify:

```bash
starship --version
```

## Install JetBrains Mono Nerd Font

Create the font directory:

```bash
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMono"
```

Download the font:

```bash
curl -L \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
    -o /tmp/JetBrainsMono.zip
```

Extract it:

```bash
unzip -q /tmp/JetBrainsMono.zip \
    -d "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMono"
```

Refresh the font cache:

```bash
fc-cache -f
```

Remove the temporary archive:

```bash
rm -f /tmp/JetBrainsMono.zip
```

Verify:

```bash
fc-list : family | grep -F "JetBrainsMono Nerd Font"
```

## Install Pukka-KDE Configuration

From the root of the cloned repository, create the required directories:

```bash
mkdir -p \
    "$HOME/.config/pukka-kde" \
    "$HOME/.config/fastfetch" \
    "$HOME/.local/share/konsole"
```

Before replacing an existing `~/.zshrc`, create a backup if the file exists:

```bash
if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" \
        "$HOME/.zshrc.pukka-backup-$(date +%Y%m%d-%H%M%S)"
fi
```

Then copy the Pukka-KDE configuration files:

```bash
cp zsh/zshrc "$HOME/.zshrc"

cp zsh/animation.zsh \
    "$HOME/.config/pukka-kde/animation.zsh"

cp starship/starship.toml \
    "$HOME/.config/starship.toml"

cp fastfetch/config.jsonc \
    "$HOME/.config/fastfetch/config.jsonc"

cp konsole/Pukka-KDE.profile \
    "$HOME/.local/share/konsole/Pukka-KDE.profile"

cp konsole/Pukka-KDE.colorscheme \
    "$HOME/.local/share/konsole/Pukka-KDE.colorscheme"
```

## Set Zsh as the Login Shell

Find the Zsh path:

```bash
command -v zsh
```

Set Zsh as the login shell:

```bash
chsh -s "$(command -v zsh)"
```

Verify:

```bash
getent passwd "$USER" | cut -d: -f7
```

Log out and log in again if necessary.

## Set the Pukka-KDE Konsole Profile

Set the Pukka-KDE profile as the default Konsole profile:

```bash
kwriteconfig6 \
    --file "$HOME/.config/konsolerc" \
    --group "Desktop Entry" \
    --key DefaultProfile \
    "Pukka-KDE.profile"
```

Refresh the KDE application cache:

```bash
kbuildsycoca6 --noincremental
```

Close all running Konsole windows and open Konsole again.

## Verify the Installation

From the repository root:

```bash
./verify.sh
```

A successful installation should report all checks as `PASS` and finish with exit code `0`.

## Manual Installation Notes

Manual installation does not automatically create a backup of an existing `~/.zshrc`.

The automatic installer creates a timestamped backup before replacing it.

Manual installation also requires you to perform each step yourself and does not automatically check whether a component is already installed.

For the simplest installation path, use:

```bash
./install.sh
```
