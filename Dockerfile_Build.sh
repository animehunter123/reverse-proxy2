#!/bin/bash

# Standard name for our docker container
target="reverse-proxy2"

echo "Building the new container: $target from the internet..."
# Or on Windows/WSL/Podman set network=host on wsl...: podman build -t docker-meteorjs-webapp . --network=host
# Note on podman windows, you can manually run it without docker-compose via: podman run  -it --rm -p 3000:3000 -v "%cd%\\..\\..:/app" docker-meteorjs-webapp bash
#docker build -t $target .  

echo "Pulling nginx:latest from the internet"
docker pull nginx:latest

#echo "Tagging it reverse-proxy2:latest"
#docker tag nginx:latest reverse-proxy2:latest

echo "Script complete. Confirm it with 'docker images' to confirm container $target:latest is now listed"
