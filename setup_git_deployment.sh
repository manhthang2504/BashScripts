#!/bin/bash
PURPLE='\033[0;35m'
BLUE='\e[0;34m'
NC='\033[0m'
timedatectl set-timezone Asia/Ho_Chi_Minh
sudo apt update -y

# Setup GIT deployment
echo -e "${BLUE}[INFO]: Setup GIT deployment${NC}"
echo -e "${BLUE}[INFO]: Create repo and initiate GIT${NC}"
cd ~
# mkdir /var/repo
cd /var/repo
mkdir crm_homepage.git 
cd crm_homepage.git
git init --bare

echo -e "${BLUE}[INFO]: Git hook${NC}"
cd hooks
echo "#!/bin/sh" > post-receive
echo "git --work-tree=/var/www/crm_homepage --git-dir=/var/repo/crm_homepage.git checkout -f" >> post-receive

chmod +x post-receive

mkdir /var/www/crm_homepage
chown -R www-data:www-data /var/www/crm_homepage
chmod -R 775 /var/www/crm_homepage
