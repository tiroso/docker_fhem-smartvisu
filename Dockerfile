FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update \ 
    && apt-get -y install curl unzip php7.0 libapache2-mod-php7.0 php7.0-mbstring \
    && curl -L http://www.smartvisu.de/download/smartVISU_2.8.zip -o /var/www/html/smartVISU_2.8.zip \
    && unzip /var/www/html/smartVISU_2.8.zip -d /var/www/html \
    && rm smartVISU_2.8.zip \
    && mv smartVISU/* /var/www/html/ \
    && rm -R smartVISU \
    && rm index.html \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/readme.txt -o readme.txt \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/config.ini.default -o config.ini \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/functions_config.php -o lib/functions_config.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/includes.php -o lib/includes.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/pages/base/configure.php -o pages/base/configure.php
    && apt-get -y curl unzip 
    && apt-get -y autoremove
    && apt-get clean
    chown -cR www-data:www-data /var/www/html
    
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
