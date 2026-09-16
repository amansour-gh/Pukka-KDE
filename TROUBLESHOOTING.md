# Pukka-KDE Troubleshooting

This guide covers common problems that may occur during installation or after applying the Pukka-KDE configuration.

## Verification

Start by running the verification script from the repository root:

```bash
./verify.sh
```

All checks should report `PASS`.

If one or more checks fail, use the relevant section below.

## Zsh Is Not Installed

Check:

```bash
command -v zsh
```

Install Zsh:

```bash
sudo dnf install -y zsh
```

Run the verification script again:

```bash
./verify.sh
```

## Zsh Is Not the Login Shell

Check the configured login shell:

```bash
getent passwd "$USER" | cut -d: -f7
```

Check the Zsh path:

```bash
command -v zsh
```

Set Zsh as the login shell:

```bash
chsh -s "$(command -v zsh)"
```

Log out and log in again if necessary.

Then verify:

```bash
./verify.sh
```

## Starship Is Missing

Check:

```bash
command -v starship
```

If Starship is not installed, install it using the official installer:

```bash
curl -sS https://starship.rs/install.sh | sh
```

Verify:

```bash
starship --version
```

## Starship Configuration Is Not Loaded

Check that the configuration exists:

```bash
ls -l "$HOME/.config/starship.toml"
```

If it is missing, copy it from the repository:

```bash
cp starship/starship.toml "$HOME/.config/starship.toml"
```

Start a new Zsh session:

```bash
exec zsh
```

## Fastfetch Is Missing

Check:

```bash
command -v fastfetch
```

Install it:

```bash
sudo dnf install -y fastfetch
```

Verify the configuration:

```bash
ls -l "$HOME/.config/fastfetch/config.jsonc"
```

If the configuration is missing:

```bash
mkdir -p "$HOME/.config/fastfetch"
cp fastfetch/config.jsonc "$HOME/.config/fastfetch/config.jsonc"
```

## JetBrains Mono Nerd Font Is Not Available

Check:

```bash
fc-list : family | grep -F "JetBrainsMono Nerd Font"
```

If nothing is returned, reinstall the font manually:

```bash
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMono"

curl -L \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
    -o /tmp/JetBrainsMono.zip

unzip -q /tmp/JetBrainsMono.zip \
    -d "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMono"

fc-cache -f

rm -f /tmp/JetBrainsMono.zip
```

Close and reopen applications that use the font.

## Konsole Does Not Use the Pukka-KDE Profile

Check that the profile exists:

```bash
ls -l "$HOME/.local/share/konsole/Pukka-KDE.profile"
```

Check the current default profile:

```bash
kreadconfig6 \
    --file "$HOME/.config/konsolerc" \
    --group "Desktop Entry" \
    --key DefaultProfile
```

Set Pukka-KDE as the default:

```bash
kwriteconfig6 \
    --file "$HOME/.config/konsolerc" \
    --group "Desktop Entry" \
    --key DefaultProfile \
    "Pukka-KDE.profile"
```

Then refresh KDE's application cache:

```bash
kbuildsycoca6 --noincremental
```

Close all Konsole windows and open Konsole again.

## Konsole Profile or Color Scheme Is Missing

Check both files:

```bash
ls -l \
    "$HOME/.local/share/konsole/Pukka-KDE.profile" \
    "$HOME/.local/share/konsole/Pukka-KDE.colorscheme"
```

If they are missing, copy them again:

```bash
cp konsole/Pukka-KDE.profile \
    "$HOME/.local/share/konsole/Pukka-KDE.profile"

cp konsole/Pukka-KDE.colorscheme \
    "$HOME/.local/share/konsole/Pukka-KDE.colorscheme"
```

## Pukka-KDE Configuration Files Are Missing

The expected files are:

```text
~/.zshrc
~/.config/pukka-kde/animation.zsh
~/.config/starship.toml
~/.config/fastfetch/config.jsonc
~/.local/share/konsole/Pukka-KDE.profile
~/.local/share/konsole/Pukka-KDE.colorscheme
```

Run:

```bash
./verify.sh
```

The failed check identifies which file is missing.

## Existing `.zshrc` Was Replaced

The automatic installer creates a timestamped backup before replacing the existing `.zshrc`.

Look for backups:

```bash
ls -lt "$HOME"/.zshrc.pukka-backup-* 2>/dev/null
```

A backup can be restored manually:

```bash
cp "$HOME/.zshrc.pukka-backup-YYYYMMDD-HHMMSS" "$HOME/.zshrc"
```

Replace the timestamp with the actual backup name.

Manual installation does not create this backup automatically. Create one before replacing an existing `.zshrc`.

## Network or Download Problems

The installer downloads Starship and the JetBrains Mono Nerd Font.

Check network access:

```bash
curl -I https://starship.rs
```

Check GitHub access:

```bash
curl -I https://github.com
```

If a download fails, verify the network connection and try again later.

## Installer Stops During Package Installation

The installer uses Fedora's `dnf`.

Run:

```bash
sudo dnf install -y \
    zsh \
    fastfetch \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    curl \
    unzip
```

If `dnf` reports a package or repository problem, resolve that Fedora package-management issue first and run the installer again.

## Run Verification After Troubleshooting

After fixing a problem:

```bash
./verify.sh
```

A successful installation should finish with:

```text
Failed: 0
```

and return exit code `0`.

## Re-run the Installer

Pukka-KDE is designed to be reinstallable.

If configuration files are missing or an installation was interrupted, the installer can be run again:

```bash
./install.sh
```

The installer creates a timestamped backup of an existing `.zshrc` before replacing it.
