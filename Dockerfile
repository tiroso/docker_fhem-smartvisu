FROM php:7-fpm-alpine

COPY entrypoint.sh /


## Install NGINX and GIT
RUN mkdir -p /etc/nginx \
    && apk add --update --no-cache curl fastjar nginx
WORKDIR "/var/www/html"
RUN curl https://github.com/Martin-Gleiss/smartvisu/archive/v2.8.zip -o smartvisu-2.8.zip \
    && fastjar xvf smartvisu-2.8.zip \
    && rm smartvisu-2.8.zip \
    && mkdir sv \
    && mv smartvisu-2.8/* ./sv/ \
    && rm -R smartvisu-2.8 \
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
