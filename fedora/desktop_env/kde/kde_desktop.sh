#!/usr/bin/env bash

xargs sudo dnf install < ../../package_list/kde/kde_desktop.txt -y

sudo systemctl disable xdm
sudo systemctl enable sddm
sudo systemctl set-default graphical.target 

