#!/bin/bash

cd "$(dirname "$0")"
echo "cluster" | ../launchGKE.sh

cd "$(dirname "$0")"
./makeConfig.sh

echo "nutserver.yaml" | ./createCluster.sh
