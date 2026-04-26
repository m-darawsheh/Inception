#!/bin/bash

mkdir -p /run/php

if [ ! -f /var/www/html/wp-config.php ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xvf latest.tar.gz
    mv wordpress/* /var/www/html/

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wp-config.php
    sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php

    chown -R www-data:www-data /var/www/html
fi

exec php-fpm7.4 -F