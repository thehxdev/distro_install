#! /usr/bin/env bash

sudo mkdir /etc/pacman.d/bak
sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/bak
sudo touch /etc/pacman.d/mirrorlist
sudo echo "Server = https://mirror.bardia.tech/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
sudo pacman -Syy
