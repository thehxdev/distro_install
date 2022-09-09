#! /usr/bin/env bash

######################
# Change these variables
USER_NAME=hx
USER_PASS=1324
ROOT_PASS=1324
######################

sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ./package_list/mbr.txt

ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
#sed -i '233s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:$ROOT_PASS | chpasswd

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid

useradd -m $USER_NAME
echo $USER_NAME:$USER_PASS | chpasswd
usermod -aG wheel $USER_NAME 
sed -i '85s/.//' /etc/sudoers

