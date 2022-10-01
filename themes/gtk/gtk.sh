#!/usr/bin/env bash

mv $HOME/.gtkrc-2.0 $HOME/.gtkrc-2.0.bak

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/gtk/.gtkrc-2.0 >> $HOME/.gtkrc-2.0

###################

mv $HOME/.config/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini.bak

curl https://raw.githubusercontent.com/hxdevlover/distro_install/main/gtk/settings.ini >> $HOME/.config/gtk-3.0/settings.ini

