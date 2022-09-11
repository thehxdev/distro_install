#!/usr/bin/env bash

sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf

sudo dnf config-manager --add-repo < ./mirror.txt

