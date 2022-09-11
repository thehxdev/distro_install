#!/usr/bin/env bash

sudo dnf install @base-x -y
sudo dnf install 'mesa*' 'libX*' 'fontconfig*' -y
#sudo dnf install 'xorg-x11-*' 'mesa*' 'libX*' 'fontconfig*' -y

sudo systemctl disable xdm

