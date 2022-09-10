#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/kde/kde_standard.txt

sudo systemctl enable sddm

