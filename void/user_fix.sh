#!/usr/bin/env bash

USER_NAME=user_name
USER_PASS=user_password

useradd -m $USER_NAME
echo $USER_NAME:$USER_PASS | chpasswd
usermod -aG wheel $USER_NAME 
sed -i '85s/.//' /etc/sudoers

