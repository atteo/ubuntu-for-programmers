# This function is executed when Alt-P is pressed
# It will add '|less' to the command and execute it
function __fish_paginate -d "Paginate the current command using the users default pager"

	set -l cmd less
	if set -q PAGER
		set cmd $PAGER
	end

	if commandline -j|grep -v "$cmd *\$" >/dev/null
		commandline -aj "|$cmd"
	end
	commandline -f execute
end
