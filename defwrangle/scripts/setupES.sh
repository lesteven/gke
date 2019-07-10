#!/bin/bash

cd scripts
chmod +x installEs.sh
./installEs.sh

sudo sed -i 's/#network.host.*/network.host: 0.0.0.0\ntransport.host: localhost/' /etc/elasticsearch/elasticsearch.yml

sudo service elasticsearch start
