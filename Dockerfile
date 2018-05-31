FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update \ 
    && apt-get -y install curl unzip php7.0 libapache2-mod-php7.0 php7.0-mbstring \
    && mkdir /var/www/html/sv \
    && curl -L http://www.smartvisu.de/download/smartVISU_2.8.zip -o /var/www/html/sv/smartVISU_2.8.zip \
    && unzip /var/www/html/sv/smartVISU_2.8.zip -d /var/www/html/sv \
    && rm /var/www/html/sv/smartVISU_2.8.zip \
    && mv /var/www/html/sv/smartVISU/* /var/www/html/sv/ \
    && rm -R /var/www/html/sv/smartVISU \
    && rm /var/www/html/index.html \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/readme.txt -o /var/www/html/sv/readme.txt \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/config.ini.default -o /var/www/html/sv/config.ini \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/functions_config.php -o /var/www/html/sv/lib/functions_config.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/lib/includes.php -o /var/www/html/sv/lib/includes.php \
    && curl https://raw.githubusercontent.com/herrmannj/smartvisu-cleaninstall/master/pages/base/configure.php -o /var/www/html/sv/pages/base/configure.php \
    && sed -i 's/driver =.*$/driver = 'Fhem'/' /var/www/html/sv/config.ini \
    && sed -i 's/pages =.*$/pages = 'MyPage'/' /var/www/html/sv/config.ini \
    && rm -R /var/www/html/sv/pages/Alber* \
    && rm -R /var/www/html/sv/pages/Gleiss* \
    && rm -R /var/www/html/sv/pages/Fleisch* \
    && rm -R /var/www/html/sv/pages/Doc* \
    && rm -R /var/www/html/sv/pages/Otter* \
    && mkdir /var/www/html/sv/pages/MyPage \
    && cp -R /var/www/html/sv/pages/_template/* /var/www/html/sv/pages/MyPage/ \
    && apt-get -y purge curl unzip \
    && apt-get -y autoremove \
    && apt-get clean \
    && chown -cR www-data:www-data /var/www/html
    
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
