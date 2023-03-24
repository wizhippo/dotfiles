#!/bin/sh

if [ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ] ; then
    PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[ -z "$TMUX" ] || export FZF_TMUX=1

if [ -e $HOME/.local/bin/vault-env ]; then
    export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.local/bin/vault-env
fi

if [ -e $HOME/.npm ]; then
    export NPM_CONFIG_PREFIX="${HOME}/.npm"
    export PATH="$PATH:$NPM_CONFIG_PREFIX/bin"
    export MANPATH="${MANPATH-$(manpath)}:$NPM_CONFIG_PREFIX/share/man"
fi
