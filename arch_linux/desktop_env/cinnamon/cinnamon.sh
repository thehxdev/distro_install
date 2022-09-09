#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ../package_list/cinnamon/cinnamon.txt

sudo systemctl enable dbus
sudo systemctl enable lightdm.service
sudo systemctl set-default graphical.target

