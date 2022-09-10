fzf_configure_bindings --directory=\ef --processes=\eP

function fzf_ag
	set token (commandline --current-token)
	#set expanded_token (eval echo -- $token)
	#set unescaped_exp_token (string unescape -- $expanded_token)

	set -x FZF_DEFAULT_COMMAND "ag --nogroup --column --color '$token' || true"

	set file_paths_selected (fzf --ansi --prompt="Ag> " --multi --bind "change:reload:ag --nogroup --column --color {q} || true" --phony --delimiter : --with-nth "1..2" --nth "2..-1" --query "$token" --preview='bat -f -H {2} {1}' --preview-window '+{2}' | cut -f1 -d':')

	if test $status -eq 0
		commandline --current-token --replace -- (string escape -- $file_paths_selected | string join ' ')
	end
end

bind \eq fzf_ag
