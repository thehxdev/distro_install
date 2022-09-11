#!/usr/bin/env bash

xargs sudo dnf install < ../../package_list/cinnamon/cinnamon_desktop.txt -y

sudo systemctl disable xdm
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target

