#!/bin/bash
PURPLE='\033[0;35m'
BLUE='\e[0;34m'
NC='\033[0m'
timedatectl set-timezone Asia/Ho_Chi_Minh
echo -e "${BLUE}[INFO]: Update packages${NC}"
sudo apt update -y
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update



echo -e "${BLUE}[INFO]: Remove Apache2${NC}"
sudo apt remove -y apache2
echo -e "${BLUE}[INFO]: Install Nginx${NC}"
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
echo -e "${BLUE}[INFO]: Install mysql${NC}"
sudo apt install -y mysql
echo -e "${BLUE}[INFO]: Install PHP 7.4 and its extensions${NC}"
sudo apt install php7.4-fpm php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl unzip -y
sudo apt install mysql-server -y
sudo mysql_secure_installation
echo -e "${BLUE}[INFO]: Install composer${NC}"
sudo apt install -y composer

echo -e "${BLUE}[INFO]: Install GIT${NC}"
sudo apt install -y git

# Setup GIT deployment
echo -e "${BLUE}[INFO]: Setup GIT deployment${NC}"
echo -e "${BLUE}[INFO]: Create repo and initiate GIT${NC}"
cd ~
mkdir /var/repo
cd /var/repo
mkdir dashboard.git 
cd dashboard.git
git init --bare

echo -e "${BLUE}[INFO]: Git hook${NC}"
cd hooks
echo "#!/bin/sh" > post-receive
echo "git --work-tree=/var/www/dashboard --git-dir=/var/repo/dashboard.git checkout -f" >> post-receive

chmod +x post-receive

mkdir /var/www/dashboard
chown -R www-data:www-data /var/www/dashboard
chmod -R 775 /var/www/dashboard

echo -e "${BLUE}[INFO]: Requisition package for installing sqlsrv${NC}"
sudo apt-get install -y unixodbc unixodbc-dev

echo -e "${BLUE}[INFO]: sqlsrv pdo_sqlsrv${NC}"
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
sudo su
printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini
exit
sudo phpenmod -v 7.4 sqlsrv pdo_sqlsrv
sudo systemctl restart php7.4-fpm

echo -e "${BLUE}[INFO]: Setup ssh public key${NC}"
mkdir -p ~/.ssh

echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2TUk544dqqxpu2gp2JSiGSnns7EzNwSpPa0fARK2LDeoc7xUQvl5fYVEWIsWXwfk+o1onfL00yyp/OtHwHQPm1hOkP8U1x/GJ7WvivpYKonJ2mTVdPslZWHvyOiDF8D9SQ4Dpv6eRoSNTI1ciLu2XbjybewkS8BH8fT+XgqCjK7hU9Dl17GtgFvA5UmK4Tn/xQTePycgOW8VWl7pdKTlFhm0ekboW7mes4xg//wPJrO21IazfF0EcVzDACCBgm6GNXwo27nos+jmyIs8Z5LMaiWmgSJYD/ufz2uLCbvzH/xdPqhIQJq1Wer+r2sW1NcnYMcF3S3/Iira9WJmz78Az thangnm@manhthang.com >> ~/.ssh/authorized_keys

chmod -R go= ~/.ssh

echo -e "${BLUE}[INFO]: Install curl${NC}"
sudo apt install -y curl

sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

#Download appropriate package for the OS version
#Choose only ONE of the following, corresponding to your OS version

#Ubuntu 18.04
curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql17
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev

echo -e "${BLUE}[INFO]: Install certbot${NC}"
sudo add-apt-repository ppa:certbot/certbot
sudo apt install -y python-certbot-nginx
sudo certbot --nginx -d app.charleswembley.com

sudo apt-get install -y supervisor
