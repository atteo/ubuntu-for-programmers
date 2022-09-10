function ls --wraps ls
	#grc ls --color -C -w (tput cols) $argv
	exa --icons --git $argv
end
