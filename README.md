# Docker container to run multiple php
## Compile image (new setup/changes applied in Dockerfile)
```bash
docker compose build
```

## Run Docker
```bash
docker compose up
## running backgroud
# docker compose up -d
```
## Run docker by version
### php 7.3
```bash
docker compose up php73
```
### php 8.2
```bash
docker compose up php82
```
### phpmyadmin
```bash
### connect to db at main host
docker compose up phpmyadmin
```
### mariadb
```bash
docker compose up mariadb
```
### Down container
```bash
docker compose down
## stop container and delete data store
docker compose down --volumes
```

## list running container
```bash
docker ps
```

## access running container
```bash
docker exec -it docker-php-82 bash
```

## PHP IntelliSense for visual studio code
Create wrapper
```bash
sudo cat <<EOF> /usr/local/bin/docker-php
#!/bin/bash
docker exec -i docker-php-82 php "$@"
EOF

sudo chmod +x /usr/local/bin/docker-php
```
In settings.json
add
```json
"php.validate.executablePath": "/usr/local/bin/docker-php"
```
