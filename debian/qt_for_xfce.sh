#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install qt5ct qt5-style-plugins breeze qt5-style-kvantum qt5-style-kvantum-themes

sudo echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment

#reboot

