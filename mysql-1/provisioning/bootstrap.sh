#!/usr/bin/env bash

sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root password root'
sudo DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y

mysql -u root -e  "
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'localhost' with grant option;
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' with grant option;
FLUSH PRIVILEGES;
";
sudo sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf
sudo service mysql restart

# mysql_secure_installation
