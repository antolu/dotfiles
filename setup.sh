#!/bin/bash

CWD=$PWD
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"

installZsh() {
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
	ln -sf $SCRIPT_DIR/zshrc			~/.zshrc
	ln -sf $SCRIPT_DIR/vimrc			~/.vimrc
	ln -sf $SCRIPT_DIR/ideavimrc		~/.ideavimrc

	mkdir -p ~/.config/i3				~/.config/i3blocks
	ln -sf $SCRIPT_DIR/i3config 		~/.config/i3/config
	ln -sf $SCRIPT_DIR/i3blocksconfig	~/.config/i3blocks/config
}

