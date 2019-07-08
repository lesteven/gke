#!/bin/bash


sudo touch /etc/apt/sources.list.d/pgdg.list
echo 'deb http://apt.postgresql.org/pub/repos/apt/ 18.04-pgdg main' | sudo tee -a /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update -y
sudo apt install postgresql -y
