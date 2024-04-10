# Linux-config

Set of configuration files for Linux

## Package prerequisites

### Required
* zsh - shell
* vim - text editor

### Optional
* neovim - text editor
* tmux - terminal multiplexer
* chezmoi - dotfile manager

### Dependencies

For neovim to function correctly, you need to install `npm`.
Additional tools that are recommended include `rsync`.

## How to set up
```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply antolu
chsh -s /bin/zsh  # set default shell to zsh
zsh  # enter zsh
```

### Other useful functions are

```
generateSSHKeychain  # generates an ed25519 keychain with your username and hostname as comment
```

