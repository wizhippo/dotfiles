#!/bin/sh

if [ ! -z "$WSL_DISTRO_NAME" ] && [ -z "$WSL_HOST_IP" ]; then
    export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
    export WSL_CLIENT_IP=$(ip -4 addr show eth0 | grep -Po 'inet \K[\d.]+')
    export DISPLAY=$WSL_HOST_IP:0.0

    powershell.exe -File $HOME/.dotfiles/apps/wsl/wsl.ps1 -HostIP $WSL_HOST_IP -ClientIP $WSL_CLIENT_IP

    ~/.local/bin/gpg-agent-relay start
fi
