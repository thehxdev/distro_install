#!/usr/bin/env bash

xargs sudo dnf install < ../../package_list/xfce/xfce_apps.txt -y --setopt=install_weak_deps=False

