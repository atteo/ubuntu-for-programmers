
function watch-command-line
  commandline -r "watch -n0.5 $history[1]"
end

function fish_user_key_bindings
  bind \ej 'thefuck-command-line'
  bind \ew 'watch-command-line'
end
