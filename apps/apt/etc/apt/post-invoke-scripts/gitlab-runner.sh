#!/usr/bin/env bash

if dpkg --get-selections | grep -q "^gitlab-runner.*install$"; then
    chgrp -R gitlab-runner /etc/gitlab-runner
    chmod g+x /etc/gitlab-runner
fi
