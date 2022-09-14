#!/usr/bin/env bash

#sudo dnf groupinstall "KDE (K Desktop Environment)" -y

xargs sudo dnf install < ../../package_list/kde/kde_desktop.txt -y

sudo systemctl disable xdm
sudo systemctl enable sddm
sudo systemctl set-default graphical.target 

