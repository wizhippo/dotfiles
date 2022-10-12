#!/bin/sh

[ ! -z "$WSL_DISTRO_NAME" ] || return 0

# HOST_NS_SEARCH_LIST=$(powershell.exe -Command '$list = (Get-DnsClient).ConnectionSpecificSuffix; [system.String]::Join(" ", $list)' | tr -d '\r' | xargs)
# NS_SEARCH_LIST=$(cat /etc/resolv.conf | grep search | awk '{print $2; exit;}')

# if [ "$HOST_NS_SEARCH_LIST" != "$NS_SEARCH_LIST" ]; then
#     sudo cat /etc/resolv.conf >/tmp/resolv.conf.new
#     sudo sed -i '/^search/d' /tmp/resolv.conf.new
#     if [ ! -z "$HOST_NS_SEARCH_LIST" ]; then
#         sudo echo "search $HOST_NS_SEARCH_LIST" >>/tmp/resolv.conf.new
#     fi
#     sudo mv -f /tmp/resolv.conf.new /etc/resolv.conf
# fi

export WSL_HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
export WSL_CLIENT_IP=$(ip -4 addr show eth0 | grep -Po 'inet \K[\d.]+')

# https://github.com/rupor-github/win-gpg-agent
# win-gpg-agent should be running first from windows

# detect what we have
# if [  $(uname -a | grep -c "Microsoft") -eq 1 ]; then
#     export ISWSL=1 # WSL 1
# elif [ $(uname -a | grep -c "microsoft") -eq 1 ]; then
#    export ISWSL=2 # WSL 2
# else
#     export ISWSL=0
# fi
# if [ ${ISWSL} -eq 1 ]; then
#     # WSL 1 could use AF_UNIX sockets from Windows side directly
#     if [ -n ${WSL_AGENT_HOME} ]; then
#         export GNUPGHOME=${WSL_AGENT_HOME}
#         export SSH_AUTH_SOCK=${WSL_AGENT_HOME}/S.gpg-agent.ssh
#     fi
# elif [ ${ISWSL} -eq 2 ]; then
#     # ${HOME}/.local/bin/win-gpg-agent-relay start
#     export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
# else
#     echo "Unkonwn WSL version"
# fi

if [ command -v wslview &> /dev/null ]; then
    export BROWSER=wslview
fi

if [ "$XDG_RUNTIME_DIR" != "/mnt/wslg/runtime-dir" ]; then
    export DISPLAY=:0.0
    # somtimes dbus is not up yet from sytemd, wait for it
    local NEXT_WAIT_TIME=0
    until [ $NEXT_WAIT_TIME -eq 5 ] || pgrep -u $UID dbus > /dev/null; do
        sleep $(( NEXT_WAIT_TIME++ ))
    done
    [ $NEXT_WAIT_TIME -lt 5 ] && dbus-update-activation-environment --systemd --all
    unset $NEXT_WAIT_TIME
fi
