#!/bin/bash

cd "$(dirname "$0")"

ip=$(gcloud compute instances list | grep elasticsearch | awk '{print $5}')
echo "$ip"

address=http://"$ip":9200
echo "$address"
echo "ADDRESS=$address" > env.properties

kubectl create configmap my-config --from-env-file=env.properties
