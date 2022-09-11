#!/usr/bin/env bash

sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf

#sudo dnf config-manager --add-repo < ./mirror.txt

sudo curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror_ir.repo >> /etc/yum.repos.d/iran_mirror.repo

