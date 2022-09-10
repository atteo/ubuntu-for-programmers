#!/bin/bash

trap "exit 1" ERR

sudo apt-get -y install git git-svn gitk kdiff3 git-gui curl

git config --global rebase.autoStash true
git config --global pull.rebase merges

curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy | sudo tee /usr/local/bin/diff-so-fancy > /dev/null
sudo chmod +x /usr/local/bin/diff-so-fancy

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"


# gitk dark colors
mkdir -p ~/.config/git/
curl https://raw.githubusercontent.com/dracula/gitk/master/gitk -o ~/.config/git/gitk

