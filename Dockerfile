ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm

ENV DEBIAN_FRONTEND=noninteractive

# System packages + PHP extension build dependencies.
# PHP < 7.4 images are based on EOL Debian bullseye, whose repos have moved
# to archive.debian.org, so point apt there first.
RUN if php -r 'exit(PHP_VERSION_ID < 70400 ? 0 : 1);'; then \
        printf 'deb http://archive.debian.org/debian bullseye main\ndeb http://archive.debian.org/debian bullseye-updates main\n' > /etc/apt/sources.list; \
        rm -f /etc/apt/sources.list.d/debian.sources; \
        APT_OPTS='-o Acquire::Check-Valid-Until=false'; \
    else \
        APT_OPTS=''; \
    fi; \
    apt-get update $APT_OPTS; \
    apt-get install -y --no-install-recommends \
        nginx \
        git \
        unzip \
        libzip-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libwebp-dev \
        libfreetype6-dev \
        libicu-dev \
        libxml2-dev \
        libpq-dev \
    && if php -r 'exit(PHP_VERSION_ID >= 70400 ? 0 : 1);'; then \
        docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    else \
        docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr; \
    fi \
    && EXT_LIST='mysqli pdo_mysql pgsql pdo_pgsql gd intl bcmath soap zip exif'; \
    if php -r 'exit(PHP_VERSION_ID < 80500 ? 0 : 1);'; then \
        EXT_LIST="$EXT_LIST opcache"; \
    fi; \
    docker-php-ext-install -j"$(nproc)" $EXT_LIST \
    && if php -r 'exit(PHP_VERSION_ID >= 70400 ? 0 : 1);'; then \
        pecl install redis; \
    else \
        pecl install redis-5.3.7; \
    fi \
    && docker-php-ext-enable redis \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Composer (from the pinned official image)
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# nginx site + entrypoint.
# Remove the distro default site so our conf.d/default.conf is the only
# "default_server" on port 80.
COPY conf/default.conf /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/sites-enabled/default
COPY scripts/entry-point.sh /usr/local/bin/entry-point.sh
RUN chmod +x /usr/local/bin/entry-point.sh

ENTRYPOINT ["/usr/local/bin/entry-point.sh"]
