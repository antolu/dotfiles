#!/bin/zsh

if [[ "$SHELL" != "*/zsh" ]]; then
    echo "This script should be sourced with zsh."
    return
fi

CWD=$PWD
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"

setupZsh() {
	if [[ ! -d ~/.zprezto ]]; then
		echo "=> Installing zprezto"
		git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null
		rm -f ~/.zshrc

		setopt EXTENDED_GLOB
		for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N)^zpreztorc^zshrc; do
			ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
		done
	fi
}

generateSSHKeychain() {
	if [[ ! -f ~/.ssh/id_ed25519 ]]; then
		echo "=> Generating ssh-keys"
		ssh-keygen -t ed25519 -C "$USER@$HOSTNAME" -N ''
		eval $(ssh-agent -s)
		ssh-add ~/.ssh/id_ed25519
	fi
}

linkConfigs() {
	ln -sf $SCRIPT_DIR/zpreztorc		~/.zpreztorc
	ln -sf $SCRIPT_DIR/zshrc			  ~/.zshrc
	ln -sf $SCRIPT_DIR/vimrc			  ~/.vimrc
	ln -sf $SCRIPT_DIR/ideavimrc		~/.ideavimrc
	ln -sf $SCRIPT_DIR/gitconfig		~/.gitconfig
  ln -sf $SCRIPT_DIR/p10k.zsh	    ~/.p10k.zsh

	mkdir -p ~/.config/i3				~/.config/i3blocks
	ln -sf $SCRIPT_DIR/i3config 		~/.config/i3/config
	ln -sf $SCRIPT_DIR/i3blocksconfig	~/.config/i3blocks/config
}

installFzfModule() {
    mkdir -p $ZPREZTODIR/contrib && cd $_
    git clone https://github.com/gpanders/fzf-prezto.git fzf
    cd fzf
    git submodule update --init
    
    cat <<EOF >> $SCRIPT_DIR/zpreztorc
# Use keybindings
zstyle ':prezto:module:fzf' key-bindings 'yes'

# Use completion
zstyle ':prezto:module:fzf' completion 'yes'

# Set height of the fzf results (comment for full screen)
zstyle ':prezto:module:fzf' height '30%'

# Open fzf results in a tmux pane (if using tmux)
zstyle ':prezto:module:fzf' tmux 'yes'

# Set colorscheme
# A list of available colorschemes is available in color.zsh
# To add more color schemes of your own, consult
# https://github.com/junegunn/fzf/wiki/Color-schemes and add values to the
# color.zsh file accordingly
zstyle ':prezto:module:fzf' colorscheme 'Solarized Light'
EOF

cd $CWD
}

