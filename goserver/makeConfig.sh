#!/bin/bash

cd "$(dirname "$0")"

ip=$(gcloud compute instances list | grep elasticsearch | awk '{print $5}')
echo "$ip"
address="http://"$ip""
echo "$address"
echo "$address" > env.conf
