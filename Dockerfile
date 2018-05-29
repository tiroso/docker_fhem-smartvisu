FROM php:7-fpm-alpine

COPY entrypoint.sh /

WORKDIR "/var/www/html"
## Install NGINX and GIT
RUN mkdir -p /etc/nginx \
    && apk --update add unzip curl nginx \
    && curl -L http://www.smartvisu.de/download/smartVISU_2.8.zip -o v2.8.zip \
    && unzip v2.8.zip \
    && rm v2.8.zip \
    && mv smartVISU/* ./ \
    && rm -R smartVISU \
    && cp -r pages/_template/ pages/MyPage/ \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/readme.txt -o readme.txt \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/config.ini.default -o config.ini \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/functions_config.php -o lib/functions_config.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/includes.php -o lib/includes.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/pages/base/configure.php -o pages/base/configure.php \
    && chown -R nginx:www-data /var/www/html \
    && chmod g+w /var/www/html \
    && chmod g+w /var/www/html/temp \
    && chmod a+x /entrypoint.sh

COPY nginx.conf /etc/nginx


ENTRYPOINT ["/entrypoint.sh"]
