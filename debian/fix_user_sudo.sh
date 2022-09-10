#! /usr/bin/env bash

# Login as root user and run this script
# This script will NOT work with sudo.

USER_NAME=your_user_name

echo "$USER_NAME ALL=(ALL:ALL) ALL" >> /etc/sudoers

