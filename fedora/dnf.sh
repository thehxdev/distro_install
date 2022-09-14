#!/usr/bin/env bash

#echo "fastestmirror=True" >> /etc/dnf/dnf.conf
echo "defaultyes=True" >> /etc/dnf/dnf.conf
echo "keepcache=True" >> /etc/dnf/dnf.conf

#dnf config-manager --add-repo < ./mirror.txt

mkdir /etc/repo_backup/
mv /etc/yum.repos.d/* /etc/repo_backup/

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror_ir.repo >> /etc/yum.repos.d/iran_mirror.repo

