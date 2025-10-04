# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a chezmoi-managed dotfiles repository that manages configuration files across macOS and Linux systems. The repository uses chezmoi templates (`.tmpl` files) to generate system-specific configurations.

## Chezmoi Basics

### File Naming Conventions
- `dot_` prefix → `.` in the home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `private_` prefix → file with 0600 permissions
- `.tmpl` suffix → template file processed by chezmoi with Go templating
- `executable_` prefix → file with executable permissions

### Common Commands
- `chezmoi edit --apply <file>` - Edit and apply a managed file in one step
- `chezmoi apply` - Apply pending changes to the home directory
- `chezmoi diff` - Show changes that would be applied
- `chezmoi add <file>` - Add a new file to chezmoi management
- `chezmoi status` - Show files that would be changed

### Template Variables
Available via `.chezmoi.toml.tmpl`:
- `.fullname` - User's full name
- `.email` - User's email address
- `.wakatime_api_key` - Wakatime API key
- `.chezmoi.os` - Operating system ("darwin" or "linux")

## Repository Structure

### Shell Configuration
- `dot_zshrc.tmpl` - Main zsh configuration with OS-specific sections
- `dot_zpreztorc` - Prezto configuration
- `dot_zprofile.tmpl` - zsh profile with OS-specific logic
- `.chezmoiexternal.toml` - External dependencies (prezto, tmux plugins)

### Editor Configs
- `dot_config/nvim/` - Neovim configuration (LazyVim-based)
- `dot_config/vim/` - Vim configuration
- `dot_config/zed/` - Zed editor configuration
- `dot_ideavimrc` - IntelliJ IdeaVim configuration

### Network Detection Scripts
Located in `dot_local/bin/`:
- `executable_atcern` - Checks if connected to CERN network (194.12.* or 128.141.* subnets)
- `executable_notatcern` - Inverse of atcern
- `executable_onsubnet` - Generic subnet detection utility
- These scripts are used in SSH config (`private_dot_ssh/config.tmpl`) for conditional host matching

### SSH Configuration
`private_dot_ssh/config.tmpl` uses conditional SSH config based on network location:
- Uses `Match exec atcern` or `Match exec notatcern` for location-aware SSH configs
- Configures GSSAPI authentication for CERN hosts

## Custom Shell Functions

Key functions defined in `dot_zshrc.tmpl`:
- `generateSSHKeychain` - Generate ed25519 SSH keypair
- `linkport <port> <hostname>` - SSH port forwarding helper
- `srcvenv <name>` - Activate virtual environment from `~/.venvs/`
- `mkc <dir>` - Make directory and cd into it
- `gitc <url> [dir]` - Clone git repo and cd into it
- `pip` - Wrapper that uses `uv pip` if available, falls back to `python -m pip`

## Development Tools

### Python
- Uses `uv` as preferred pip replacement when available
- Custom pip aliases for CERN-specific package repositories (accpy-install, pypi-install)
- Editable installs use `--config-settings editable_mode=compat`

### Linting (when applicable)
- Ruff: `ruff check --fix --unsafe-fixes --preview`

## OS-Specific Notes

### macOS
- Uses Homebrew (both x86_64 via `ibrew` and native)
- Alacritty terminal configuration in `dot_config/alacritty/`

### Linux
- Arch Linux package manager aliases (pac)
- i3 window manager configuration in `dot_config/i3/`
- systemd service management aliases (srestart, sstatus, etc.)
