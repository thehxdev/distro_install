#!/usr/bin/env bash

xargs sudo dnf install < ./package_list/base.txt -y

sudo dnf groupinstall "Hardware Support" "Standard" "Fonts" "Input Methods" -y

sudo dnf remove 'selinux*' -y

#sudo dnf groupinstall "Printing Support"
