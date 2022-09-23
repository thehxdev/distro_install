#! /usr/bin/env bash

sudo mkdir /etc/pacman.d/bak
sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/bak
sudo touch /etc/pacman.d/mirrorlist
sudo echo "Server = http://ftp.halifax.rwth-aachen.de/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
sudo pacman -Syy

