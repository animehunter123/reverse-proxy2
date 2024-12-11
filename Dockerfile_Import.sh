#!/bin/bash

# Standard name for our docker container
#target="reverse-proxy2"
target="nginx"

echo "Importing image to $target:latest..."
docker load -i ./$target.tar.bz2

echo "Script complete. You should now have a $target in 'docker images'."
