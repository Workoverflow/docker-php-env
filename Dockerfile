FROM php:7.4-fpm-alpine AS app

# Define config vars
ENV APP_ENV=dev
ENV SYS_NGINX_DIR=/etc/nginx

RUN apk update && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        curl \
        wget \
        git \
        nginx \
        supervisor \
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
    && pecl install mcrypt-1.0.3 \
    && pecl install redis-5.1.1 \
    && pecl install xdebug-2.9.0 \
    && pecl install apcu \
    && pecl install zip-1.15.5 \
    && rm -rf /tmp/pear \
    && rm -rf ${SYS_NGINX_DIR}/sites-enabled/* ${SYS_NGINX_DIR}/sites-available/* \
    && mkdir -p /var/log/supervisor

 RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && apk del tzdata \
    && docker-php-ext-install -j$(nproc) bz2 mysqli pdo_mysql sockets \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install intl \
    && docker-php-ext-configure intl \
    && docker-php-ext-enable bz2 mysqli gd pdo_mysql mcrypt redis xdebug intl opcache apcu sockets zip

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Copy source files to container
COPY . /var/www/html
WORKDIR /var/www/html

# Copy configs
COPY docker-config/supervisord/supervisord.conf /etc/supervisord.conf 
COPY docker-config/nginx/nginx.conf /etc/nginx/nginx.conf 
COPY docker-config/nginx/conf.d/default.conf ${SYS_NGINX_DIR}/conf.d/default.conf 
COPY docker-config/php/${APP_ENV}.ini /usr/local/etc/php/php.ini
COPY docker-config/php/fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Create dirs before start
RUN mkdir /run/nginx && mkdir /run/supervisord

WORKDIR /var/www/html/app

# Use 80 port
EXPOSE 80

# Start supervisor
ENTRYPOINT ["/usr/bin/supervisord", "--pidfile=/run/supervisord/supervisord.pid"]