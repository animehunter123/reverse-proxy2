#!/bin/bash

# Standard name for our docker container
#target="reverse-proxy2"
target="nginx"

echo "Removing any existing containers image files..."
rm --verbose -f ./$target.tar* 2>/dev/null

echo "Exporting the new container: $target from this docker host..."
docker save $target:latest > ./$target.tar

echo "Compressing the container with bzip2 for space..."
bzip2 ./$target.tar

echo "Script complete. You should now have a $target.tar.bz2 file."
