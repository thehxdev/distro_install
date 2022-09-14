#! /usr/bin/env bash

sudo pacman -Sy --needed --disable-download-timeout - < ./package_list/kvm.txt

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/br10.xml > $HOME/br10.xml

cd $HOME/
sudo virsh net-define br10.xml
sudo virsh net-start br10
sudo virsh net-autostart br10

#sudo gpasswd -a libvirt-qemu $USER

