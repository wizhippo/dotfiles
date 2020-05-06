#!/bin/sh
 
if [ -z "$DISPLAY" ]; then
    # eval $(dbus-launch --sh-syntax --close-stderr)
    # TODO shudown dbus on exit
    # maybe share across tmux session
else
    if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
        if [ ! -r ~/.cache/myshell-dbus-uuid ]; then
            dbus-uuidgen > ~/.cache/myshell-dbus-uuid
        fi
        eval $(dbus-launch --autolaunch=$(cat ~/.cache/myshell-dbus-uuid) --sh-syntax --close-stderr)
    fi
fi
