#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed base-devel git go

sleep 3

git clone https://aur.archlinux.org/yay.git
#sudo chown -R  $USER:$USER yay
cd yay
makepkg -si
