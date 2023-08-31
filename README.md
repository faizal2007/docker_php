# Docker container to run multiple php
## Compile image (new setup)
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
php 7.3
```bash
docker compose up php73
```
php 8.2
```bash
docker compose up php82
```
phpmyadmin
```bash
## generate phpmyadmin config 
### connect to db at main host
./scripts/config.inc-gen.sh
docker compose up phpmyadmin
```
## list running container
```bash
docker ps
```

## access running container
```bash
docker exec -it docker-php-82 bash
```
