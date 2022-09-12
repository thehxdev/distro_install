#!/usr/bin/env bash

RUNIT_SERVICE_DIR=/var/service/

xargs sudo xbps-install -y < ../../package_list/kde/kde.txt

sudo ln -s /etc/sv/NetworkManager/ $RUNIT_SERVICE_DIR
sudo ln -s /etc/sv/dbus/ $RUNIT_SERVICE_DIR
sudo ln -s /etc/sv/sddm/ $RUNIT_SERVICE_DIR

