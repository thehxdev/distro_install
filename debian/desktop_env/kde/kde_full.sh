#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/kde/kde_full.txt -y

sudo systemctl enable sddm
sudo systemctl enable NetworkManager
sudo systemctl set-default graphical.target
