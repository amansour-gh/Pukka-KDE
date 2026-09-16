# Pukka-KDE

A lightweight and portable terminal environment for Fedora KDE Plasma.

Pukka-KDE provides a clean, modern terminal setup built around **Konsole + Zsh + Starship + Fastfetch**, with minimal customization and easy reinstallation.

The goal is to keep the terminal experience consistent across multiple Fedora KDE machines without depending on a large desktop customization framework.

## Features

* **Konsole** terminal profile
* **Zsh** as the default shell
* **Starship** prompt
* **Fastfetch** system information
* **JetBrains Mono Nerd Font**
* **zsh-autosuggestions**
* **zsh-syntax-highlighting**
* Custom startup animation
* Konsole transparency and blur
* Git information shown automatically inside Git repositories
* Portable configuration
* Automatic `.zshrc` backup during installation
* Designed for easy reinstallation and deployment across multiple machines

## Directory Structure

```text
Pukka-KDE/
├── install.sh
├── verify.sh
├── MANUAL_INSTALL.md
├── TROUBLESHOOTING.md
├── README.md
├── .gitignore
├── fastfetch/
│   └── config.jsonc
├── konsole/
│   ├── Pukka-KDE.profile
│   └── Pukka-KDE.colorscheme
├── starship/
│   └── starship.toml
└── zsh/
    ├── zshrc
    └── animation.zsh
```

## Requirements

This project is designed primarily for:

* Fedora Linux
* KDE Plasma
* Konsole
* Wayland or X11

The installer handles the required packages automatically.

## Installation

Clone the repository:

```bash
git clone https://github.com/amansour-gh/Pukka-KDE.git
```

Enter the directory:

```bash
cd Pukka-KDE
```

Run the installer:

```bash
./install.sh
```

The installer will:

1. Install the required Fedora packages.
2. Install Starship if it is not already installed.
3. Install JetBrains Mono Nerd Font if it is not already installed.
4. Back up the existing `.zshrc`.
5. Install the Pukka-KDE configuration.
6. Set Zsh as the login shell.
7. Set the Pukka-KDE Konsole profile as the default profile.

After installation, close all Konsole windows and open Konsole again.

### Verify the Installation

Run:

```bash
./verify.sh
```

The verification script checks the installed commands, login shell, font, and Pukka-KDE configuration files.

A successful verification should report all checks as `PASS` and finish with exit code `0`.

### Manual Installation

To install the configuration manually instead of using the automated installer, see:

[MANUAL_INSTALL.md](MANUAL_INSTALL.md)

### Troubleshooting

For common installation and configuration problems, see:

[TROUBLESHOOTING.md](TROUBLESHOOTING.md)

````

بعد لصق هذا الجزء في `README.md` وحفظه، نفّذ:

```bash
cd /mnt/Data/github/"KDE terminal profile"

git diff -- README.md
git diff --check
git status --short
````

وبعدها نراجع الـ diff مرة واحدة قبل الـ commit.

## What Gets Installed

### Zsh

Zsh is used as the default interactive shell.

The configuration includes:

* Starship
* Autosuggestions
* Syntax highlighting
* Startup animation

### Starship

The prompt uses a clean two-line layout:

```text
╭─ ~/Projects/Pukka
╰─ ❯
```

When inside a Git repository, Git information is displayed automatically:

```text
╭─ ~/Projects/Pukka  main
╰─ ❯
```

Git information is intentionally kept secondary because the terminal is not primarily used for Git work.

### Fastfetch

Fastfetch displays a compact system summary when a new interactive terminal starts.

Example:

```text
OS: Fedora Linux 44 (KDE Plasma Desktop Edition) x86_64
Host: Inspiron 3593
Kernel: Linux 7.2.5-200.fc44.x86_64
DE: KDE Plasma
WM: KWin (Wayland)
Shell: zsh
Terminal: konsole
CPU: Intel Core i5
GPU: NVIDIA + Intel
Memory: ...
```

### Konsole

The project includes a dedicated Konsole profile named:

```text
Pukka-KDE
```

The profile includes:

* Zsh
* JetBrains Mono Nerd Font
* Custom color scheme
* Transparent background
* Blur
* Blinking cursor
* Animated cursor

## Reinstallation

Pukka-KDE is designed to make reinstalling Fedora easier.

After reinstalling Fedora KDE, simply clone the repository again and run:

```bash
cd Pukka-KDE
./install.sh
```

The installer creates a timestamped backup of an existing `.zshrc` before replacing it.

Example:

```text
~/.zshrc.pukka-backup-20260916-001515
```

## Deploying to Multiple Computers

The same repository can be used on multiple Fedora KDE computers.

For each machine:

```bash
git clone https://github.com/amansour-gh/Pukka-KDE.git
cd Pukka-KDE
./install.sh
```

This keeps the terminal environment consistent across machines while avoiding manual configuration.

## Customization

The configuration is intentionally kept lightweight.

Main configuration files:

```text
starship/starship.toml
fastfetch/config.jsonc
zsh/zshrc
zsh/animation.zsh
konsole/Pukka-KDE.profile
konsole/Pukka-KDE.colorscheme
```

Changes can be made directly to these files and committed back to the repository.

## Philosophy

Pukka-KDE is intentionally different from a full desktop customization framework.

The project focuses on:

* Minimal changes
* Easy maintenance
* Easy reinstallation
* Portability
* Consistent configuration
* Fedora KDE compatibility
* Keeping the default KDE environment recognizable

The goal is a polished terminal experience without turning the entire desktop into a heavily customized environment.

## License

This project is provided as-is for personal and organizational use.

You are free to modify the configuration to suit your needs.
