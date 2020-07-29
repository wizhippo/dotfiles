#!/bin/sh

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e $HOME/.local/bin/edit ]; then
    export EDITOR=$HOME/.local/bin/edit
fi

[ -z "$TMUX" ] || export FZF_TMUX=1

if [ -e $HOME/.local/bin/vault-env ]; then
    export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.local/bin/vault-env
fi
