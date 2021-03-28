FROM	debian:buster

LABEL	maintainer="rotrojan <rotrojan@student.42.fr>"

RUN		apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y wget nginx mariadb-server php-fpm php-mysql php-xml php-mbstring

COPY	./srcs/ /tmp

RUN		mv /tmp/default /etc/nginx/sites-available/localhost \
		&& ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled \
		&& mkdir /var/www/html/localhost \
		&& chown -R www-data /var/www/html/localhost/ \
		&& chmod -R 755 /var/www/html/localhost/

RUN		mkdir -p /etc/nginx/ssl/ \
		&& openssl req -x509 -out /etc/nginx/ssl/localhost.crt \
			-keyout /etc/nginx/ssl/localhost.key -newkey rsa:2048 -nodes -sha256 \
			-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=rotrojan/CN=localhost"

RUN		wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
		&& tar -xf phpMyAdmin-*all-languages.tar.gz \
		&& rm -rf https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
		&& mv phpMyAdmin-*all-languages /var/www/html/localhost/phpmyadmin \
		&& cp /tmp/config.inc.php /var/www/html/localhost/phpmyadmin/config.inc.php \
		&& mkdir /var/www/html/localhost/phpmyadmin/tmp \
		&& chmod -R 777 /var/www/html/localhost/phpmyadmin/tmp

RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar -xf latest.tar.gz \
		&& rm -rf /latest.tar.gz \
		&& mv /tmp/wp-config.php /wordpress/wp-config.php \
		&& mv /wordpress /var/www/html/localhost/

EXPOSE		80 443

CMD			["/bin/sh", "/tmp/run.sh"]
