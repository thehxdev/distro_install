#!/usr/bin/env bash

sudo dnf groupinstall “GNOME Desktop Environment” -y

sudo dnf install firefox vim alacritty

sudo systemctl enable gdm
sudo systemctl set-default graphical.target

