#! /usr/bin/env bash

xargs sudo apt install < ../../package_list/kde/kde_full.txt

sudo systemctl enable sddm

