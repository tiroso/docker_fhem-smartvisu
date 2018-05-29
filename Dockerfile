FROM php:7-fpm-alpine

COPY entrypoint.sh /
WORKDIR "/var/www/html"

## Install NGINX and GIT
RUN mkdir -p /etc/nginx \
    && apk add --update --no-cache curl unzip nginx \
    && curl http://www.smartvisu.de/download/smartvisu-2.8.zip -o smartvisu-2.8.zip \
    && unzip smartvisu-2.8.zip \
    && rm smartvisu-2.8.zip \
    && mkdir sv \
    && mv smartVISU/* ./sv/ \
    && rm -R smartVISU \
    && rm index.html \
    && rm -r sv/pages/alber* \
    && rm -r sv/pages/gleiss* \
    && rm -r sv/pages/docu \
    && rm -r sv/pages/fleisch* \
    && rm -r sv/pages/otto* \
    && cp sv/pages/_template sv/pages/MyPage \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/readme.txt -o sv/readme.txt \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/config.ini.default -o sv/config.ini \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/functions_config.php -o sv/lib/functions_config.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/includes.php -o sv/lib/includes.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/pages/base/configure.php -o sv/pages/base/configure.php \
    && chmod a+x /entrypoint.sh

COPY nginx.conf /etc/nginx


ENTRYPOINT ["/entrypoint.sh"]
