#!/bin/bash

set -ex

TERM="xterm-256color"
green='\033[0;32m'
reset='\033[0m'

cd "$( dirname "${BASH_SOURCE[0]}" )"

export DEBIAN_FRONTEND=noninteractive

runScript() {
	local directory="$1"
	echo -e "${green}Running ${directory}${reset}"
	(
		cd "$directory"
		./setup.sh
	)
}

runAllScripts() {
	readarray -d '' scripts < <(find -L . -maxdepth 1 -type d -name '[[:digit:]][[:digit:]]-*' -print0 | sort -z)

	for script in "${scripts[@]}"; do
		runScript "$script"
	done
}

script="$1"
if ! [[ -z "$script" ]]; then
	runScript "$script"
else
	runAllScripts
fi


echo "Finished sucessfully"

exit 0
