#!/bin/sh

[ -z "$TMUX" ] || export FZF_TMUX=1

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] ; then
    PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

if [ -e $HOME/.local/bin/vault-env ]; then
    export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.local/bin/vault-env
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
