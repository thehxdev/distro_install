#! /usr/bin/env bash

sudo pacman -Sy --needed --disable-download-timeout --ignore gnome-games,gnome-chess - < ../package_list/gnome/gnome.txt

sudo systemctl enable dbus
sudo systemctl enable gdm.service
sudo systemctl set-default graphical.target

