#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y wget 
sudo apt-get install -y apache2
sudo apt-get install -y php libapache2-mod-php7.2
sudo a2enmod php7.2
sudo service apache2 restart
sudo wget --no-check-certificate https://raw.githubusercontent.com/cloudZeroToHero/DevOpsCamp-Terraform-Azure/main/Code/05-WebServer/index.php -O /var/www/html/index.php
sudo wget --no-check-certificate https://raw.githubusercontent.com/cloudZeroToHero/DevOpsCamp-Terraform-Azure/main/Code/05-WebServer/phpinfo.php -O /var/www/html/phpinfo.php