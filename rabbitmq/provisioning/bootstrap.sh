#!/usr/bin/env bash

echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -

sudo apt-get update -y
sudo apt-get install rabbitmq-server -y

sudo rabbitmq-plugins enable rabbitmq_management

sudo rabbitmqctl add_user common common
sudo rabbitmqctl set_user_tags common administrator
sudo rabbitmqctl set_permissions -p / common ".*" ".*" ".*"

