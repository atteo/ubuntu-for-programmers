#!/bin/bash

set -ex

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sudo add-apt-repository -y ppa:neovim-ppa/stable
#sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get -y install neovim curl git aspell-pl universal-ctags build-essential cmake python3-dev golang-go fzf vifm ripgrep shfmt shellcheck ccls nodejs

mkdir -p ~/.vim/{tmp,spell,undodir}

echo "Installing ViM spell checking files"
for lang in pl.utf-8 en.utf-8; do
    curl -o ~/.vim/spell/$lang.spl -z ~/.vim/spell/$lang.spl "http://ftp.vim.org/pub/vim/runtime/spell/$lang.spl"
done

echo "Installing custom .vimrc"
chmod 644 ~/.vimrc || true
cp -r .vimrc .vim ~/
chmod 444 ~/.vimrc

mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/

cp neovim.fish ~/.config/fish/conf.d/
cp coc-settings.json ~/.config/nvim/coc-settings.json

vim +PlugUpdate +UpdateRemotePlugins +PlugClean +VimspectorUpdate +CocUpdateSync +'q!' +'q!' +'q!'

#cd ~/.vim/plugged/YouCompleteMe
#python3 install.py --all
