#!/bin/bash

trap "exit 1" ERR

sudo apt-get -y install tmux powerline tmuxinator

pullOrClone() {
	local url="$1"
	local directory="$2"

	if [[ -d "$directory" ]]; then
		( cd "$directory"; git pull )
	else
		git clone "$url" "$directory"
	fi
}


pullOrClone "https://github.com/tmux-plugins/tpm" ~/.tmux/plugins/tpm

cp tmux.conf ~/.tmux.conf

tmux source ~/.tmux.conf || true

wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish -O ~/.config/fish/completions/tmuxinator.fish

~/.tmux/plugins/tpm/scripts/install_plugins.sh
