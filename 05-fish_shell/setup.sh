#!/bin/bash

# More safety, by turning some bugs into errors.
set -euCo pipefail
IFS=$'\n\t'

scriptDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


# new permissions required by reptyr
sudo sed -rie 's,kernel.yama.ptrace_scope = 1,kernel.yama.ptrace_scope = 0,' /etc/sysctl.d/10-ptrace.conf
sudo sysctl --system

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update

# Install fish shell and grc
# sudo apt-add-repository -y ppa:fish-shell/release-2
# sudo apt-get update
sudo apt-get -y install fish grc ccze curl fd-find bat reptyr jq thefuck python3-pip git silversearcher-ag timg


mkdir -p ~/.local/bin


fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; set --universal fzf_fish_custom_keybinding'

cp fish_plugins ~/.config/fish/fish_plugins

fish -c 'fisher update'


sed -ie 's,builtin pwd -P,builtin pwd,' ~/.config/fish/functions/fish_prompt.fish

cp -r conf.d completions functions ~/.config/fish/

trap clean EXIT

clean() {
	popd
	set -u
	rm -rf "$tempDirectory"
}

getLatestReleaseFromGitHub() {
	local repo="$1"
	local tagFilter="${2:-}"

	echo >&2 -n "Searching repo $repo for release tag $tagFilter... "

	local releases
	releases="$(curl --silent "https://api.github.com/repos/$repo/releases")" || (echo >&2 "Failed to fetch releases from GitHub, try 'curl --silent \"https://api.github.com/repos/$repo/releases\"' && return 1")

	local tags
	tags="$(echo "$releases" | jq -r '.[] | .tag_name')" || (echo >&2 "Failed to get tags from GitHub API."; return 1)

	if [[ -n "$tagFilter" ]]; then
		tags="$(echo "$tags" | grep "$tagFilter")"
	fi

	local latestTag
	latestTag="$(echo "$tags" | head -n 1)"

	local result
	result="$(curl --silent "https://api.github.com/repos/$repo/releases/tags/$latestTag" | jq -r '.assets[].browser_download_url')"

	if [[ -z "$result" ]]; then
		echo >&2 "not found"
		exit 1
	fi

	echo >&2 "found $result"

	echo -n "$result"
}

installDeb() {
	local url="$1"
	wget -O "application.deb" "$url"
	sudo dpkg -i "application.deb"
	rm "application.deb"
}

installDebFromGitHub() {
	local repoName="$1"
	local debFilePattern="$2"
	local tagFilter="${3:-}"

	echo "Installing $repoName..."

	local url
	url=$(getLatestReleaseFromGitHub "$repoName" "$tagFilter" | grep -F "$debFilePattern")

	installDeb "$url"
}

mkdir -p ~/.config/bat
cp bat/config ~/.config/bat/config

if [[ ! -f /usr/bin/bat ]]; then
	sudo ln -s batcat /usr/bin/bat
fi

tempDirectory="$(mktemp -d)"
pushd "$tempDirectory"

pip3 install bpytop --upgrade

exaUrl=$(getLatestReleaseFromGitHub "ogham/exa" | grep -F "linux-x86_64-v")

wget -O application.zip "$exaUrl"
unzip application.zip
mv bin/exa ~/.local/bin/exa
mv completions/exa.fish ~/.config/fish/completions/
rm application.zip

procsUrl=$(getLatestReleaseFromGitHub dalance/procs | grep -F "x86_64-linux")
wget -O application.zip "$procsUrl"
unzip application.zip
mv procs ~/.local/bin/
rm application.zip


installDebFromGitHub "watchexec/watchexec" "x86_64-unknown-linux-gnu.deb" "cli"

dustUrl=$(getLatestReleaseFromGitHub bootandy/dust | grep -F "x86_64-unknown-linux-gnu")
wget -O application.tar.gz "$dustUrl"
tar -xz < application.tar.gz
mv dust-*-x86_64-unknown-linux-gnu/dust ~/.local/bin/
rm application.tar.gz


installDebFromGitHub "ClementTsang/bottom" "x86_64-unknown-linux-gnu.deb"

deltaUrl="$(getLatestReleaseFromGitHub "dandavison/delta" | grep "amd64.deb" | grep -v "musl")"
installDeb "$deltaUrl"

installDebFromGitHub "muesli/duf" "_amd64.deb"

dogUrl="$(getLatestReleaseFromGitHub "ogham/dog" | grep unknown-linux-gnu | grep -v 'minisig')"

wget -O application.zip "$dogUrl"
unzip application.zip
mv bin/dog ~/.local/bin/dog
rm application.zip


installDebFromGitHub "rs/curlie" "linux_amd64.deb"

xhUrl="$(getLatestReleaseFromGitHub ducaale/xh | grep -F "x86_64-unknown-linux-musl.tar.gz")"
wget -O application.tar.gz "$xhUrl"
tar -xz < application.tar.gz
mv xh-*/xh ~/.local/bin/xh
rm application.tar.gz

echo "Done"


