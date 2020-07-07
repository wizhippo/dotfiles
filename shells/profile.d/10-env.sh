#!/bin/sh

export EDITOR=$HOME/.local/bin/edit
[ -z "$TMUX" ] || export FZF_TMUX=1
export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.local/bin/vault-env

export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
