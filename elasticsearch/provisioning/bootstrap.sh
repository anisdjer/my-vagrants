#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get upgrade -y
# install openjdk-7 
sudo apt-get purge openjdk* -y
sudo apt-get -y install openjdk-7-jdk
# install ES
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get update -y && sudo apt-get install elasticsearch -y 
sudo update-rc.d elasticsearch defaults 95 10
sudo /etc/init.d/elasticsearch start
# either of the next two lines is needed to be able to access "localhost:9200" from the host os
echo "network.bind_host: 0" | sudo tee /etc/elasticsearch/elasticsearch.yml
echo "network.host: 0.0.0.0" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
#sudo echo "http.port: 80" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
# enable dynamic scripting
echo "script.inline: on" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "script.indexed: on" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
# enable cors (to be able to use Sense)
echo "http.cors.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "http.cors.allow-origin: /https?:\/\/.*/" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo /etc/init.d/elasticsearch restart
