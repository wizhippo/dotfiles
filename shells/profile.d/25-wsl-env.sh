#!/bin/sh

if [ ! -z "$WSL_DISTRO_NAME" ] && [ -z "$WSL_HOST_IP" ]; then
    SEARCH_LIST=$(powershell.exe -Command '$list = (Get-DnsClientGlobalSetting).SuffixSearchList; [system.String]::Join(" ", $list)' | tr -d '\r')
    if [ ! -z "$SEARCH_LIST" ]; then
        sudo cat /etc/resolv.conf > /tmp/resolv.conf.new
        sudo sed -i '/^search/d' /tmp/resolv.conf.new
        sudo echo "search $SEARCH_LIST" >> /tmp/resolv.conf.new
        sudo mv -f /tmp/resolv.conf.new /etc/resolv.conf
    fi;

    export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
    export WSL_CLIENT_IP=$(ip -4 addr show eth0 | grep -Po 'inet \K[\d.]+')
    export DISPLAY=$WSL_HOST_IP:0.0

    powershell.exe -File $HOME/.dotfiles/apps/wsl/wsl.ps1 -HostIP $WSL_HOST_IP -ClientIP $WSL_CLIENT_IP

    if [ ! -z $(echo $(~/.local/bin/gpg-agent-relay status) | grep 'is not running') ]; then
        ~/.local/bin/gpg-agent-relay start
    fi;
fi
