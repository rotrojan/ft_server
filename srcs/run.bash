#!/bin/bash

# Init Nginx
mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled
unlink /etc/nginx/sites-enabled/default
mkdir /var/www/localhost
#chmod -R 755 /var/www/localhost

# Init MariaDB
service mysql start
mysql < /tmp/create_database


# Basic pages for test purpose
mv /tmp/index.html /var/www/localhost/index.html
mv /tmp/info.php /var/www/localhost/info.php

# SSl
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum

# Init phpmMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
tar -xf phpMyAdmin-*all-languages.tar.gz
mv phpMyAdmin-*all-languages /usr/share/phpmyadmin
mkdir -p /var/lib/phpmyadmin/tmp
chown -R www-data:www-data /var/lib/phpmyadmin
cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php

#/var/www/localhost/phpmyadmin
#mkdir /var/www/l/phpmyadmin
#mkdir /usr/share/phpmyadmin
#cp /usr/share/phpmyadmin/phpMyAdmin-*all-languages/config.sample.inc.php /var/www/localhost/phpmyadmin/config.inc.php

rm phpMyAdmin-*all-languages.tar.gz

service php7.3-fpm start
service nginx start
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
