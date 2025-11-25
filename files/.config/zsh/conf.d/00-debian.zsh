#!/usr/bin/env zsh

if ! . "$ZDOTDIR/conf.d/debian/env.zsh"; then
    echo "Error: Could not source $ZDOTDIR/conf.d/debian/env.zsh"
    return 1
fi

if [[ $- == *i* ]] && [ -f "$ZDOTDIR/conf.d/debian/terminal.zsh" ]; then
    . "$ZDOTDIR/conf.d/debian/terminal.zsh" || echo "Error: Could not source $ZDOTDIR/conf.d/debian/terminal.zsh"
fi
