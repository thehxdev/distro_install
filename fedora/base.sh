#!/usr/bin/env bash

xargs sudo dnf install < ./package_list/base.txt -y

echo "Disabling selinux..." ; sleep 5 ; grubby --update-kernel ALL --args selinux=0

#sudo dnf groupinstall "Hardware Support" "Standard" "Fonts" "Input Methods" -y
#sudo dnf groupinstall "Printing Support"
