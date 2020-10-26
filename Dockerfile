FROM php:5.6.35-fpm

RUN apt-get -qq update && apt-get install -qqy libgearman-dev libtidy-dev supervisor gearman netcat imagemagick libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmcrypt-dev libbz2-dev libxml2-dev libssl-dev libedit-dev libcurl4-openssl-dev libmysqlclient-dev && apt-get clean
RUN docker-php-source extract \
    && cd /usr/src/php \ 
    &&./configure $(php-config --configure-options | sed 's/enable-mysqlnd/disable-mysqlnd/' | sed 's/CFLAGS=.*//') --with-mysql=/usr --with-mysqli=/usr/bin/mysql_config --with-mysql-sock=/var/run/mysqld/mysqld.sock --with-pdo-mysql=/usr \
    && make -j$(nproc) \
    && make install \
    && docker-php-source delete
