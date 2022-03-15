FROM nginx:latest AS nginx

ENV SYS_NGINX_DIR=/etc/nginx

RUN rm -rf ${SYS_NGINX_DIR}/sites-enabled/* ${SYS_NGINX_DIR}/sites-available/* /var/www/*
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone

# Define working directory.
WORKDIR /etc/nginx