#!/bin/sh

# MariaDB initialization
service mysql start
mysql < /tmp/create_database

# Basic pages for test purpose
mv /tmp/index.html /var/www/html/localhost/index.html
mv /tmp/info.php /var/www/html/localhost/info.php

# Autoindex toggling script
mv /tmp/autoindex /usr/local/bin/autoindex

# Launch server
service php7.3-fpm start
service nginx start
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
