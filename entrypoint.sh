#!/bin/sh

ARGS=$@

rm /var/www/html/.DS_Store

chown -R nginx:www-data /var/www/html
chmod g+w /var/www/html
chmod g+w /var/www/html/temp

php-fpm -D
nginx -g 'daemon off;' $ARGS
