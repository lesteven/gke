#!/bin/bash

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo sed -i 's/#network.host.*/network.host: 0.0.0.0\ntransport.host: localhost/' /etc/elasticsearch/elasticsearch.yml

sudo service elasticsearch start
