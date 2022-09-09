#! /usr/bin/env bash

sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ../package_list/kde/kdelite.txt

# If you use Intel, Install these packages too:
sudo pacman -S xf86-video-intel intel-ucode

# If you use AMD, Install these packages too:
# sudo pacman -S xf86-video-amdgpu amd-ucode

sudo systemctl enable dbus
sudo systemctl enable sddm
