# Docker for windows
if [ ! -z WSL_CLIENT_IP ]; then
    export XDEBUG_REMOTE_HOST=$WSL_CLIENT_IP
    return 0
fi

# Docker native
ip -4 addr show docker0 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    export XDEBUG_REMOTE_HOST=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+') 
    return 0
fi
