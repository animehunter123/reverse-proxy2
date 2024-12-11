0. Create a webapp called cp2, and it runs normally on http://my-docker01-server.MYDOMAIN.local:5002
1. Add a "CNAME" to DNS like "cp2.MYDOMAIN.local" which resolves to "my-docker01-server.MYDOMAIN.local." (with dot)
2. Add a external network dependancy to your cp2 webpage's docker-compose.yaml, so something like:
==================
version: '3'
services:
  docker-meteorjs-webapp:
    image: docker-meteorjs-webapp:latest
    container_name: docker-meteorjs-webapp
    restart: always
    ports:
      - '5020:3000'
    volumes:
      - '../:/app'
    networks:              # <--- add this
      - proxy-network      # <--- add this
networks:                  # <--- add this 
  proxy-network:           # <--- add this 
    external: true         # <--- add this
==================
3. Now the nginx reverse network MUST BE UP before you can start the container, so create it via:
docker network create proxy-network
4. Create/add a relevent config file to the nginx settings file, ./conf/default.conf:
==================
server {
    listen 80;
    server_name cp2;

    location / {
        proxy_pass http://my-docker01-server.MYDOMAIN.local:5020;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
==================

5. Start up the reverse-proxy, then the cp2, then you should be able to get to http://cp2/ or http://cp2.MYDOMAIN.local/

