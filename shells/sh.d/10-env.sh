#!/bin/sh

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] ; then
    PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

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
