#!/bin/bash

# Start php-fpm
#php-fpm7.3 -F -R
php-fpm7.3 -D -R
# Start Nginx
nginx -c /etc/nginx/nginx.conf -g 'daemon off;'


