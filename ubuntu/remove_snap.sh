#!/usr/bin/env bash

#sudo snap list | cut -f 1 -d " " | xargs -L 1 sudo snap remove --purge

sudo rm -rf /var/cache/snapd/

sudo apt autoremove --purge snapd gnome-software-plugin-snap

rm -fr ~/snap

sudo apt-mark hold snapd

