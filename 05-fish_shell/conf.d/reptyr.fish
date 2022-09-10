
function move_session_to_tmux -d "Moves session to tmux"
	set pid (jobs -lp | tail -n 1)
	bg

	if test -n "$pid"
		disown $pid
		exec tmux new-session "fish -C \"reptyr $pid\""
	else
		exec tmux
	end

end

bind \er move_session_to_tmux
