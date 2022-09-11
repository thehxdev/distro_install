#!/usr/bin/env bash

sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf

sudo dnf config-manager --add-repo < curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror.txt

