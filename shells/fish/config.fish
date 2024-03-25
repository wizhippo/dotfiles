set -U fish_greeting "🐟"

if test -e "$HOME/.local/bin/vault-env"
  set -gx ANSIBLE_VAULT_PASSWORD_FILE "$HOME/.local/bin/vault-env"
end

if test -d "$HOME/.local/share/JetBrains/Toolbox/scripts"
  fish_add_path -m "$HOME/.local/share/JetBrains/Toolbox/scripts"
end

if test -d "$HOME/.local/bin"
  fish_add_path -m "$HOME/.local/bin"
end

if pgrep -a -u (id -u) gnome-keyring-d >/dev/null
  set -gx GNOME_KEYRING_CONTROL "/run/user/$(id -u)/keyring"
  set -gx SSH_AUTH_SOCK "/run/user/$(id -u)/keyring/ssh"
end

if set -q WSL_CLIENT_IP
    set -x XDEBUG_CONFIG "remote_host=$WSL_CLIENT_IP client_host=$WSL_CLIENT_IP"
    return 0
end

if ip -4 addr show docker0 >/dev/null ^/dev/null
    set -x XDEBUG_CONFIG "remote_host=host.docker.internal client_host=host.docker.internal"
    return 0
end

if status is-interactive
    oh-my-posh init fish --config ~/.local/share/poshthemes/grandpa-style.omp.json | source
end
