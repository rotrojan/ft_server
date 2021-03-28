# 42 - ft_server

Web server using a LEMP Stack (Linux - Debian Buster, NginX, MariaDB and
PHPMyadmin) running in one single Docker container.
##### Features :
- Default user in data base (name : "example_user", password : "password").
- SSL (certificates need to be manually approved) ; all sites works both with http and https.
- Autoindex can be toggled on and off from within the container.

To access autoindex :  
http://localhost  
https://localhost

To access WordPress site (on the first attempt to connect, you will have to create a new user and a site) :  
http://localhost/wordpress  
https://localhost/wordpress

To manage your WordPress :  
http://localhost/wordpress/wp-admin  
https://localhost/wordpress/wp-admin  
http://localhost/wordpress/wp-login.php  
https://localhost/wordpress/wp-login.php

To manage your data base (user : "example_user", password : "password") :  
http://localhost/phpmyadmin  
https://localhost/phpmyadmin

Build Docker image from Dockerfile :
```
docker build -t ft_server .
```
Run the docker image (http and https ports of the container are mapped on the corresponding ports of the host machine) :
```
docker run -p80:80 -p443:443 ft_server
```
List all running containers :
```
docker ps
```
Access a shell inside the container (if only one is running alone) :
```
doker exec -it $(docker ps -q) /bin/sh
```
From this point, you can enable or disable the autoindex :
```
autoindex [on|off]
```
Stop all running containers :
```
docker stop $(docker ps -q)
```
Clean all built containers images :
```
docker system prune --all
```
