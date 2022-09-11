#!/usr/bin/env bash

sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf

xargs -L 1 sudo dnf config-manager --add-repo < ./mirror.txt -y

