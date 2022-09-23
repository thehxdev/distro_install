#!/usr/bin/env bash

echo "defaultyes=True" >> /etc/dnf/dnf.conf
echo "keepcache=True" >> /etc/dnf/dnf.conf
#echo "fastestmirror=True" >> /etc/dnf/dnf.conf
#echo "exclude='selinux-*'" >> /etc/dnf/dnf.conf

mkdir /etc/repo_backup/
mv /etc/yum.repos.d/* /etc/repo_backup/

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror_ir.repo >> /etc/yum.repos.d/iran_mirror.repo
curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/fedora/mirror_ir_updates.repo >> /etc/yum.repos.d/iran_mirror_updates.repo

