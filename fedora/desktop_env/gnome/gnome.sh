#!/usr/bin/env bash

sudo dnf groupinstall “GNOME Desktop Environment” -y

sudo dnf install gdm

sudo systemctl enable gdm

