#!/bin/bash

# install and configure postgresql
cd scripts
chmod +x ./setupPostgres.sh
chmod +x ./configPostgres.sh
./setupPostgres.sh
./configPostgres.sh

# create user and dataase
sudo -u postgres psql < userdb.sql

# pull data and init scripts from github
cd ..
git clone https://github.com/lesteven/sampleData.git

# add data and tables to postgresql in inline b/c does not work if
# done here

