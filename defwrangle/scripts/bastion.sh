#!/bin/bash

sudo apt-get update -y
sudo apt install python-pip -y
sudo apt-get install libpq-dev -y

pip install psycopg2
pip install elasticsearch

