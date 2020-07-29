#!/bin/sh

# Select lines from history to remove
dh() {
    cat $HISTFILE | nl | fzf -m | awk '{ print $1 "d" }' | paste -s -d";" | xargs -I{} sed -i '{}' $HISTFILE
    [ `ps -ocomm= -p$$` = "zsh" ] && fc -R && echo "History file updated. Reload the session to see its effects."
    [ `ps -ocomm= -p$$` = "bash" ] && history -c && history -r
}
