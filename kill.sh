#!/bin/bash


# get terraform dir
read -p "Enter dir: " dir

# go to script dir
cd "$(dirname "$0")/$dir"

printf yes | terraform destroy
