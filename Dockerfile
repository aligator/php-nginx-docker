FROM alpine:latest
MAINTAINER aligator

RUN apk add --no-cache --update-cache \
	nginx \
	php7 \
	php7-fpm \
	php7-curl \
	php7-ctype \
	php7-dom \
	php7-gd \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-session \
	php7-simplexml \
	php7-zip \
	php7-xml \
	php7-apcu \
	php7-opcache \
	supervisor && \
	mkdir /web && \
	echo "<?php phpinfo(); ?>" > /web/index.php 

COPY supervisord.ini /etc/supervisor.d/supervisord.ini
COPY ./overwrite/php/fpm-pool.conf /etc/php7/php-fpm.d/yyy_fpm-pool.conf
COPY ./overwrite/php/php.ini /etc/php7/conf.d/zz_custom.ini
COPY ./overwrite/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./overwrite/nginx/default.conf /etc/nginx/conf.d/default.conf

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]


