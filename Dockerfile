FROM		debian:buster

LABEL		maintainer="rotrojan <rotrojan@student.42.fr>"

RUN			apt-get update 			\
			&& apt-get upgrade -y	\
			&& apt-get install -y 	\
				wget				\
				nginx				\
				mariadb-server		\
				php-fpm				\
				php-mysql	

ADD			./srcs/ /tmp

EXPOSE		80

CMD			["/bin/bash", "/tmp/run.bash"]
