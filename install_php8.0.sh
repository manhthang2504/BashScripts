#!/bin/bash
PURPLE='\033[0;35m'
BLUE='\e[0;34m'
NC='\033[0m'
sudo apt update -y
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
echo -e "${BLUE}[INFO]: Install PHP 8.0 and its extensions${NC}"
sudo apt install php8.0-fpm php8.0-common php8.0-mysql php8.0-xml php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-dev php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl unzip -y

