#!/usr/bin/env bash

echo "=====> Updating ..."
apt-get update

echo "=====> create /var/www"
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

echo "=====> Install php"
apt-get install php5-common libapache2-mod-php5 php5-cli php5-mysql -y

echo "=====> Instaling apache"
apt-get install -y apache2

echo "=====> Install composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer.phar
alias composer='/usr/local/bin/composer.phar'

echo "=====> Install symfony"
curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony



echo "=====> Add user tuto"
useradd tuto --home /var/www/html/tuto --create-home

echo "=====> Finish"
