#!/usr/bin/env bash

mkdir $HOME/.config/gtk-3.0/
touch $HOME/.config/gtk-3.0/settings.ini

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/gtk/.gtkrc-2.0 >> $HOME/.gtkrc-2.0
#curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/gtk/settings.ini >> $HOME/.config/gtk-3.0/settings.ini
