#set -x MANPAGER "bat -l man -p"
#
# workaround for https://github.com/sharkdp/bat/issues/652
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
