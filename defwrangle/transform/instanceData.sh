#!/bin/bash

gcloud compute instances list > list.txt

exip=$( grep bastion list.txt | awk '{print $6}')
echo "$exip"

pg=$(grep postgres list.txt | awk '{print $5}')
echo "$pg"

es=$(grep elasticsearch list.txt | awk '{print $5}')
echo "$es"

ssh -tt -oStrictHostKeyChecking=no -i ~/.ssh/google_compute_engine steven@"$exip" 'cd bastion &&\
    sed -i 's/=localhost/="$pg"/' config.py &&\
    sed -i 's/localhost/"$es"/' config.py &&\
    python2 transform2.py'


