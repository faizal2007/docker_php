#!/bin/bash
set -e

# Start PHP-FPM (daemonized; runs as www-data via the default pool config)
php-fpm -D

# Start nginx in the foreground
exec nginx -g 'daemon off;'


