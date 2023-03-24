#!/bin/sh

[ ! -z "$WSL_DISTRO_NAME" ] || return 0

export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
export WSL_CLIENT_IP=$(ip -4 addr show eth0 | grep -Po 'inet \K[\d.]+')

if [ command -v wslview &> /dev/null ]; then
    export BROWSER=wslview
fi

if [ "$XDG_RUNTIME_DIR" != "/mnt/wslg/runtime-dir" ]; then
    export DISPLAY=:0.0
    # somtimes dbus is not up yet from systemd, wait for it
    NEXT_WAIT_TIME=0
    until [ $NEXT_WAIT_TIME -eq 5 ] || pgrep -u $UID dbus >/dev/null; do
        sleep $(( NEXT_WAIT_TIME++ ))
    done
    [ $NEXT_WAIT_TIME -lt 5 ] && dbus-update-activation-environment --systemd --all
    unset $NEXT_WAIT_TIME
fi

if pgrep -a -u $UID gnome-keyring-d >/dev/null; then
    export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
    export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
fi
