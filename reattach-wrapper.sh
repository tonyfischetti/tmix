#!/bin/sh

if [[ "$(uname)" == "Darwin" ]]; then
    $HOME/.tmux/reattach-to-user-namespace $@
else
    exec "$@"
fi

