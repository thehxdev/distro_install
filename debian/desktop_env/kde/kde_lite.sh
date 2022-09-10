#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/kde/kde_lite.txt

sudo systemctl enable sddm

