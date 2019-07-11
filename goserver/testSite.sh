#!/bin/bash

ip=$(kubectl get svc | grep nutriservice | awk '{print $4}')
echo "$ip"

curl "$ip"

