#! /usr/bin/env bash

echo "Installing Packages..."
sleep 2; sudo pacman -Sy --noconfirm --needed --disable-download-timeout - < ./package_list/mbr.txt

sleep 2

echo "Configuring System..."
sleep 2
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
echo root:1234 | chpasswd     # Change root password

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable acpid

# Change USER in this section.
useradd -m USER
echo USER:1234 | chpasswd
usermod -aG wheel USER
sed -i '85s/.//' /etc/sudoers

echo "########################"
echo "If you don't set the root Password in script,the default password is 1234"
echo "########################"
