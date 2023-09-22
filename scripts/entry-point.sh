#!/bin/bash

# Start php-fpm
#php-fpm7.3 -F -R
which php-fpm7.3 > /dev/null && php-fpm7.3 -D -R
which php-fpm8.2 > /dev/null && php-fpm8.2 -D -R
# Start Nginx
cat <<EOF> /var/www/html/index.php
<?php phpinfo();?>
EOF

sed -i "s|\(root\s\+\)[^;]\+;|\1${DOCUMENT_ROOT};|" /etc/nginx/sites-available/default
nginx -c /etc/nginx/nginx.conf -g 'daemon off;'


