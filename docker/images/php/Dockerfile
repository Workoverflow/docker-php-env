FROM php:8.1-fpm-alpine AS php

# Define config vars
ARG APP_ENV=dev

RUN apk update && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        curl \
        wget \
        git \
        bzip2-dev \
        libxml2-dev \
        imagemagick-dev \
        freetype \
        freetype-dev \
        jpeg-dev \
        libjpeg-turbo-dev \
        libpng \
        libpng-dev \
        libmcrypt-dev \
        zlib-dev \
        libzip-dev \
        yaml-dev \
        tzdata \
        icu-dev \
        libpq-dev \
        libsodium-dev \
    && pecl install redis \
    && pecl install xdebug \
    && pecl install apcu \
    && pecl install zip \
    && rm -rf /tmp/pear

 RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata \
    && docker-php-ext-install -j$(nproc) bz2 pdo pdo_pgsql pgsql mysqli pdo_mysql sockets \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install intl \
    && docker-php-ext-configure intl \
    && docker-php-ext-enable pgsql pdo_pgsql mysqli pdo_mysql bz2 gd redis xdebug intl opcache apcu sockets zip

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy source files to container
#COPY ./app /var/www
WORKDIR /var/www
RUN rm -rf /var/www/*

# Copy configs
ADD ./docker/config/php/${APP_ENV}.ini /usr/local/etc/php/conf.d/${APP_ENV}-custom.ini
ADD ./docker/config/php/fpm.conf /usr/local/etc/php-fpm.d/www.conf