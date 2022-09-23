#!/usr/bin/env bash

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak

sudo curl https://raw.githubusercontent.com/thehxdev/distro_install/main/ubuntu/sources_focal.list \
    >> /etc/apt/sources.list

sudo apt update

