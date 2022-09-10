#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ../../package_list/gnome/gnome.txt

sudo systemctl enable dbus
sudo systemctl enable gdm.service
sudo systemctl set-default graphical.target

