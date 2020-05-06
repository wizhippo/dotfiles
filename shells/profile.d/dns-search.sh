#!/bin/sh

sudo cat /etc/resolv.conf > /tmp/resolv.conf.new
sudo echo "search local" >> /tmp/resolv.conf.new
sudo mv -f /tmp/resolv.conf.new /etc/resolv.conf
