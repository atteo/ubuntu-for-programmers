complete -c cdr -x -n 'git rev-parse --is-inside-work-tree' -a '(pushd "./"(git rev-parse --show-cdup); __fish_complete_directories (commandline -ct) ""; popd; )'
