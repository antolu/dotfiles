#!/bin/bash

CWD=$PWD
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"

if [[ ! -f ~/.ssh/id_ed25519 ]]; then
	echo "=> Generating ssh-keys"
	ssh-keygen -t ed25519 -C "$USER@$HOSTNAME"
	eval $(ssh-agent -s)
	ssh-add ~/.ssh/id_ed25519
fi

ln -sf $SCRIPT_DIR/zpreztorc	~/.zpreztorc
ln -sf $SCRIPT_DIR/zshrc	~/.zshrc
ln -sf $SCRIPT_DIR/vimrc	~/.vimrc
