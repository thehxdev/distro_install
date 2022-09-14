#!/usr/bin/env bash

xargs sudo dnf install < ./package_list/base.txt -y

sudo dnf groupinstall "Hardware Support" "Standard" "Fonts" "Input Methods"

#sudo dnf groupinstall "Printing Support"
