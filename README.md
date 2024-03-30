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

