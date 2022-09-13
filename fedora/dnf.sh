#!/usr/bin/env bash

sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf
sudo echo "defaultyes=True" >> /etc/dnf/dnf.conf
sudo echo "keepcache=True" >> /etc/dnf/dnf.conf

#sudo dnf config-manager --add-repo < ./mirror.txt

sudo mkdir /etc/repo_backup/
sudo mv /etc/yum.repos.d/* /etc/repo_backup/

sudo curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror_ir.repo >> /etc/yum.repos.d/iran_mirror.repo

