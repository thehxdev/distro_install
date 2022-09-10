#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ../../package_list/kde/kde_lite.txt

sudo systemctl enable dbus
sudo systemctl enable sddm
systemctl set-default graphical.target

