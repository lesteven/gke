#!/bin/bash


read -p "Enter file: " file

cd "$(dirname "$0")"

kubectl create -f "$file"
