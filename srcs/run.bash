#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.bash                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bigo </var/spool/mail/bigo>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/27 11:14:09 by bigo              #+#    #+#              #
#    Updated: 2020/07/27 11:14:09 by bigo             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Nginx configuration
mv /tmp/default /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
mkdir /var/www/html/localhost
chown -R www-data /var/www/html/localhost/
chmod -R 755 /var/www/html/localhost/

# MariaDB initialization
service mysql start
mysql < /tmp/create_database

# Basic pages for test purpose
mv /tmp/index.html /var/www/html/localhost/index.html
mv /tmp/info.php /var/www/html/localhost/info.php

# SSl
mkdir -p /etc/nginx/ssl/
openssl req -x509 -out /etc/nginx/ssl/localhost.crt \
	-keyout /etc/nginx/ssl/localhost.key -newkey rsa:2048 -nodes -sha256 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=rotrojan/CN=localhost"

# Install phpmMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xf phpMyAdmin-*all-languages.tar.gz
rm -rf \
	https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mv phpMyAdmin-*all-languages /var/www/html/localhost/phpmyadmin
cp /var/www/html/localhost/phpmyadmin/config.sample.inc.php \
	/var/www/html/localhost/phpmyadmin/config.inc.php

# Install Wordpress
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm -rf /latest.tar.gz
mv /tmp/wp-config.php /wordpress/wp-config.php
mv /wordpress /var/www/html/localhost/

# Launch server
service php7.3-fpm start
service nginx start
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
