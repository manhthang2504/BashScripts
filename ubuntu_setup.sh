#!/bin/bash
@My first script
PURPLE='\033[0;35m'
BLUE='\e[0;34m'
NC='\033[0m'

echo "Starting"
echo -e "${BLUE}[INFO]: Update packages and run upgrade${NC}"
sudo apt update
sudo apt -y install git
sudo apt upgrade

echo -e "${BLUE}[INFO]: Installing zsh${NC}"
sudo apt -y install zsh


echo -e "${BLUE}[INFO] Installing pip (package manager for Python)${NC}"
sudo apt -y install python3-pip

echo -e "${BLUE}[INFO] Downloading Oh-My-Zsh and installing it${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh install.sh


echo -e "${BLUE}[INFO] You may want to change the ZSH_THEME in ~/.zshrc into 'agnoster' theme${NC}"
#The background of the prompt where the directory part is shown is too dark. Let’s make it light blue:
sed -i '0,/blue/{s/blue/39d/}' ~/.oh-my-zsh/themes/agnoster.zsh-theme

#Enable autocorrection
#It’s disabled by default.
sed -i 's/# ENABLE_CORRECTION="true"/ENABLE_CORRECTION="true"/g' ~/.zshrc

#Installing Powerline font for Windows. These fonts making terminal display icons correctly
echo -e "${BLUE}[INFO] Installing Powerline fonts to display git fork corectly${NC}"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

#clean up
cd ..
rm -rf fonts
sudo apt-get -y install fonts-powerline

echo -e "${BLUE}[INFO] PHP, Unzip${NC}"
sudo apt -y install php-cli unzip
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo -e "${BLUE}[INFO] Installing PHP extensions: MB String${NC}"
sudo apt -y install php7.4-mbstring

echo -e "${BLUE}[INFO] Installing VS Code${NC}"
sudo apt -y install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update
sudo apt -y install code