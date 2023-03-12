# Linux-config

Set of configuration files for Linux

## How to set up
```shell
git clone https://gitlab.com/antonlu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
zsh  # enter zsh
source setup.sh
installZsh
installFzfModule
linkConfigs  # note this will overwrite your current .zshrc, .zprofile, .vimrc etc.
chsh -s /bin/zsh  # set default shell to zsh
```

Other useful functions are

```
generateSSHKeychain  # generates an ed25519 keychain with your username and hostname as comment
```

