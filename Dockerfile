FROM alpine:latest
MAINTAINER aligator

RUN apk add --no-cache \
	nginx \
	php82 \
	php82-fpm \
	php82-curl \
	php82-dom \
	php82-gd \
	php82-json \
	php82-mbstring \
	php82-openssl \
	php82-session \
	php82-simplexml \
	php82-zip \
	php82-xml \
	php82-apcu \
	php82-opcache \
	php82-ctype \
	supervisor && \
	mkdir /web && \
	echo "<?php phpinfo(); ?>" > /web/index.php 

COPY supervisord.ini /etc/supervisor.d/supervisord.ini
COPY ./overwrite/php/fpm-pool.conf /etc/php82/php-fpm.d/yyy_fpm-pool.conf
COPY ./overwrite/php/php.ini /etc/php82/conf.d/zz_custom.ini
COPY ./overwrite/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./overwrite/nginx/default.conf /etc/nginx/conf.d/default.conf

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]


