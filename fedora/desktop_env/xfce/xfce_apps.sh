#!/usr/bin/env bash

#sudo echo "exclude='gnome*'" >> /etc/dnf/dnf.conf

xargs sudo dnf install < ../../package_list/xfce/xfce_apps.txt -y

