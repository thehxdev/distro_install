#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed --disable-download-timeout git curl

sleep 3

git clone https://aur.archlinux.org/pikaur.git
cd pikaur/
makepkg -si
