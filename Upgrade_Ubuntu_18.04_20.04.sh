#!/bin/bash
PURPLE='\033[0;35m'
BLUE='\e[0;34m'
NC='\033[0m'

sudo apt update -y
sudo apt upgrade -y
# sudo reboot
sudo apt --purge autoremove
sudo apt install update-manager-core -y
sudo apt install ubuntu-release-upgrader-core
sudo do-release-upgrade -d
lsb_release -a
