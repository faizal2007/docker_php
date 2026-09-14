# Docker container to run multiple PHP versions

Ready-to-use PHP development environment with PHP-FPM + nginx, Composer,
MariaDB, Redis and phpMyAdmin. Mounts your project folder and serves it without
any server configuration.

## Requirements
- Docker Engine 20+ with the Compose v2 plugin (`docker compose`)

## Setup (first time only)
```bash
cp env-example .env
mkdir -p www   # create the code dir first; otherwise Docker makes it root-owned
```
Then edit `.env` and set at least `MARIADB_ROOT_PASSWORD`.

## Start the stack
```bash
docker compose up -d
```

## Run a single service
```bash
docker compose up -d php82      # PHP 8.2 + nginx -> http://localhost:8082
docker compose up -d php73      # PHP 7.3 + nginx -> http://localhost:8073
docker compose up -d php85      # PHP 8.5 + nginx -> http://localhost:8085
docker compose up -d mariadb    # MySQL-compatible DB -> localhost:3306
docker compose up -d redis      # Redis -> localhost:6379
docker compose up -d phpmyadmin # http://localhost:8080
```

## Rebuild after changing the Dockerfile
```bash
docker compose build
# or rebuild and restart a single version
docker compose up -d --build php82
```

## Stop / cleanup
```bash
docker compose down            # stop containers
docker compose down --volumes  # also delete the database data
```

## Useful commands
```bash
docker ps                                  # list running containers
docker exec -it docker-php-82 bash         # shell into a container
./scripts/bash                             # shell into the default container
PHP_CONTAINER=docker-php-73 ./scripts/bash # shell into PHP 7.3
./scripts/composer install                 # Composer in the default container
PHP_CONTAINER=docker-php-73 ./scripts/composer install
```

## PHP IntelliSense for VS Code
Create a wrapper that runs `php` inside the container:
```bash
sudo tee /usr/local/bin/docker-php >/dev/null <<'EOF'
#!/bin/bash
docker exec -i docker-php-82 php "$@"
EOF
sudo chmod +x /usr/local/bin/docker-php
```
Then in VS Code `settings.json`:
```json
"php.validate.executablePath": "/usr/local/bin/docker-php"
```

## Notes
- `php73`, `php82` and `php85` are built from the same `Dockerfile` via the `PHP_VERSION`
  build arg. Add another version by adding a compose service with a different arg.
- Your code is mounted from `WORKING_DIR` into `/var/www/html`.
- Redis is reachable from PHP at `redis:6379`; the `redis` PECL extension is
  already installed in every PHP image.
- To add extra PHP extensions (e.g. `imagick`), edit the `Dockerfile`.
  Some extensions are PECL-only on newer PHP and may need a version-specific pin
  for PHP 7.3.

