FROM php:7-fpm-alpine

COPY entrypoint.sh /

WORKDIR "/var/www/html"
## Install NGINX and GIT
RUN mkdir -p /etc/nginx \
    && apk --update add curl nginx \
    && curl -L https://github.com/Martin-Gleiss/smartvisu/archive/v2.8.tar.gz -o v2.8.tar.gz \
    && tar -xvzf v2.8.tar.gz \
    && rm v2.8.tar.gz \
    && mkdir sv \
    && mv smartvisu-2.8/* ./sv/ \
    && mkdir sv/temp \
    && rm -R smartvisu-2.8 \
    && rm -r sv/pages/alber* \
    && rm -r sv/pages/gleiss* \
    && rm -r sv/pages/docu \
    && rm -r sv/pages/fleisch* \
    && rm -r sv/pages/ott* \
    && cp -r sv/pages/_template/ sv/pages/MyPage/ \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/readme.txt -o sv/readme.txt \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/config.ini.default -o sv/config.ini \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/functions_config.php -o sv/lib/functions_config.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/includes.php -o sv/lib/includes.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/pages/base/configure.php -o sv/pages/base/configure.php \
    && chown -R nginx:www-data /var/www/html \
    && chmod g+w /var/www/html \
    && chmod g+w /var/www/html/temp \
    && chmod a+x /entrypoint.sh

COPY nginx.conf /etc/nginx


ENTRYPOINT ["/entrypoint.sh"]
