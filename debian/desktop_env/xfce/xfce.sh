#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/xfce/xfce.txt

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
sudo systemctl set-default graphical.target
