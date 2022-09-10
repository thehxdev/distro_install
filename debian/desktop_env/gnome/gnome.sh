#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/gnome/gnome.txt -y

sudo systemctl enable gdm
sudo systemctl enable NetworkManager
sudo systemctl set-default graphical.target
