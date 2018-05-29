#!/bin/sh

ARGS=$@

rm /var/www/html/.DS_Store

php-fpm -D
nginx -g 'daemon off;' $ARGS
