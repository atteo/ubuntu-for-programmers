function cdr
	if git rev-parse --is-inside-work-tree > /dev/null;
		cd "./"(git rev-parse --show-cdup)"/$argv"
	end
end
