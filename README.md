# i3wm Dotfiles Setup

This repository contains the automated configuration for an **i3wm** workstation on Arch Linux. It uses symbolic links (symlinks) so that any changes made within this repository are instantly applied to your system.

## 📂 Project Structure

```text
.
├── core.sh              # Main installation & symlinking script
├── git-ssh.sh           # Git identity & SSH key configuration
├── home-config/         # Files for $HOME (~/.bashrc, ~/.xinitrc)
├── alacritty/           # Terminal emulator configuration
└── i3/                  # Window Manager configuration

```

---

## 🚀 Installation & Execution

To avoid permission issues, scripts are executed by directly calling the **Bash** interpreter.

### 1. Clone the repository

Ensure you enter the directory after cloning, as the scripts use the current path (`pwd`) to create symbolic links.

```bash
git clone <your-repo-url>
cd <repo-name>

```

### 2. Configure Git & SSH

This script sets up your global Git identity, generates an SSH key (ed25519), and automatically copies it to your clipboard.

```bash
bash git-ssh.sh

```

*Note: Remember to add the generated key to your GitHub/GitLab account before proceeding.*

### 3. Install System & Configurations

This script installs all required packages (i3, Audio, Fonts, Dev Tools, etc.) and symlinks your config files.

```bash
bash core.sh

```

---

## 🛠️ Post-Installation

### Apply Terminal Changes

To activate your new `.bashrc` and the SSH agent in the current session without closing the terminal, run:

```bash
source ~/.bashrc

```

### Launch the Desktop Environment

Once the process is complete, enter i3 by typing:

```bash
startx

```

---

## ⚠️ Important Maintenance (Symlinks)

Using `bash <script>` simplifies execution, but the **symbolic link** logic remains the same:

* **Absolute Paths:** The script links configuration files to the current location of this folder. **Do not move the repository folder** after installation.
* **Quick Fix:** If you must move the repository to a different location, simply navigate to the new path and run:
```bash
bash core.sh

```


This will automatically update all symlinks to the new path.

---

## ⌨️ Core Shortcuts (Cheat Sheet)

| Action | Shortcut |
| --- | --- |
| Open Terminal (Alacritty) | `$mod + Enter` |
| App Launcher (Rofi) | `$mod + d` |
| Kill Active Window | `$mod + Shift + q` |
| Quick Neovim | `$mod + n` |
| Exit Menu (Power/Logout) | `$mod + 0` |
| Screenshot (Select Area) | `$mod + Shift + p` |
