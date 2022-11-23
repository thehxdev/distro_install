#! /usr/bin/env bash

sudo apt install qemu-system libvirt-daemon-system virt-manager qemu-utils bridge-utils netcat-openbsd dnsmasq vde2 ovmf ebtables

sudo systemctl enable --now libvirtd.service

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/br10.xml > $HOME/br10.xml

cd $HOME/
sudo virsh net-define br10.xml
sudo virsh net-start br10
sudo virsh net-autostart br10

sudo gpasswd -a libvirt $USER

