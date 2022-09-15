#!/usr/bin/env bash

sudo dnf install @virtualization iptables-nft dnsmasq bridge-utils edk2-ovmf ebtables-services

sudo systemctl enable libvirtd
sudo systemctl start libvirtd

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/br10.xml >> $HOME/br10.xml

cd $HOME/
sudo virsh net-define br10.xml
sudo virsh net-start br10
sudo virsh net-autostart br10

