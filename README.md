# AthereOS 2.0
NixOS on my laptop

# Overview
Hardware is Lenovo Ideapad Flex 5 2-in-1

## Highlights
- Uses `impermanence` with a BTRFS volume
- MangoWC as Window Manager
- Flake-based
- WIP: nix-sops

# Specs
## Desktop
- **Color Scheme:** idk i made it up (Blue-Violet-ish Haze or whatever)
- **Window Manager**: MangoWC
- **Login/Display Manager**: ReGreet
- **Status Bar**: Eww
- **Terminal**: Wezterm + Ghostty
- **Terminal Multiplexer**: Zellij
- **Shell**: Nushell
- **Launcher**: Rofi 
- **Notifications**: SwayNC
- **Screen Lock**: Hyprlock
- **Idle Manager**: Wayidle
- **Wallpaper Engine**: wpaperd
- **Clipboard Manager**: cliphist + wl-paste

## Applications
- **File Manager**: Yazi
- **Bluetooth Manager**: BlueTUI
- **Editor**: Helix
- **Web Browser**: Zen Browser
- **Music**: Kev

# Git Commit Convention
<details>
  <summary>Mostly a note for myself</summary>

  ## Core Commits
  - **feat**: A new feature for the user, not a new feature for the build script

  - **fix**: A bug fix for the user, not a fix for a build script

  - **docs**: Documentation-only changes (README updates, code comments)

  - **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons)

  - **refactor**: A code change that neither fixes a bug nor adds a feature (restructuring logic for clarity)

  - **perf**: A code change that improves performance

  - **test**: Adding missing tests or correcting existing tests

  - **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm, or your Nix flakes)

  - **ci**: Changes to CI configuration files and scripts (example scopes: GitHub Actions, Travis, GitLab CI)

  - **chore**: Other changes that don't modify src or test files (e.g., updating .gitignore)

  ## Custom Commits
  - **pkgs**: Add or remove a package

</details>


# Acknowledgements
## Fonts
- Jetbrains Mono Nerd Font
- [Library 3AM](https://www.fontspace.com/library-3-am-font-f30355) by Igor Kosinky

