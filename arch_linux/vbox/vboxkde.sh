#! /usr/bin/env bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

pacman -Sy xf86-video-vmware xorg sddm plasma firefox papirus-icon-theme dolphin-plugins kde-system-meta ark kate kcalc kfind konsole unzip p7zip gwenview okular archlinux-wallpaper dbus plasma-wayland-session vlc openvpn spectacle kwallet kwalletmanager

sudo systemctl enable dbus
sudo systemctl enable sddm

reboot
