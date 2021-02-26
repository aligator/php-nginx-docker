#!/bin/sh

CONFIG_DIR=/overwrite

OWNER=${OWNER:-65534}
GROUP=${GROUP:-65534}

# create users matching ids passed if necessary
if [[ ${GROUP} -gt 65534 || ${GROUP} -lt 1000 ]]; then
  echo "invalid gid"
fi

if [[ ${OWNER} -gt 65534 || ${OWNER} -lt 1000 ]]; then
  echo "invalid uid"
fi


if getent passwd ${OWNER} ; then deluser $(getent passwd ${OWNER} | cut -d: -f1); fi
if getent group ${GROUP} ; then delgroup $(getent group ${GROUP} | cut -d: -f1); fi

addgroup -g $GROUP http
adduser -D -u $OWNER -s /sbin/nologin -G http http
  
# copy overwrite files if they exist
if [ -f ${CONFIG_DIR}/nginx/nginx.conf ]; then
  cp ${CONFIG_DIR}/nginx/nginx.conf /etc/nginx/nginx.conf
fi
if [ -f ${CONFIG_DIR}/nginx/default.conf ]; then
  cp ${CONFIG_DIR}/nginx/default.conf /etc/nginx/conf.d/default.conf
fi

if [ -f ${CONFIG_DIR}/php/fpm-pool.conf ]; then
  cp ${CONFIG_DIR}/php/fpm-pool.conf /etc/php7/php-fpm.d/zz_custom.conf
fi
if [ -f ${CONFIG_DIR}/php/php.ini ]; then
  cp ${CONFIG_DIR}/php/php.ini /etc/php7/conf.d/zz_custom.ini
fi

chown http:http /web

echo setup finished
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
