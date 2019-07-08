
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf

# change 127.0.0.1/32 to 0.0.0.0/0
sudo sed -i '0,/127.0.0.1\/32/{s/127.0.0.1\/32/0.0.0.0\/0/}' /etc/postgresql/10/main/pg_hba.conf

sudo service postgresql restart
