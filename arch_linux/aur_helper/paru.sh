#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed base-devel git

sleep 3

git clone https://aur.archlinux.org/paru.git
#sudo chown -R  $USER:$USER paru
cd paru
makepkg -si
