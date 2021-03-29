# 42 - ft_server

Web server using a LEMP Stack (Linux - Debian Buster, NginX, MariaDB and
PHPMyadmin) running in one single Docker container.
##### Features :
- Default user in data base (name : "example_user", password : "password").
- SSL (certificates need to be manually approved) ; all sites works both with http and https.
- Autoindex can be toggled on and off from within the container.

Build Docker image from Dockerfile :
```
docker build -t ft_server .
```
Run the docker image (http and https ports of the container are mapped on the corresponding ports of the host machine) :
```
docker run -p8080:80 -p8443:443 ft_server
```
To access autoindex :  
http://localhost:8080  
https://localhost:8443

To access WordPress site (on the first attempt to connect, you will have to create a new user and a site) :  
http://localhost:8080/wordpress  
https://localhost:8443/wordpress

To manage your WordPress :  
http://localhost:8080/wordpress/wp-admin  
https://localhost:8443/wordpress/wp-admin  
http://localhost/wordpress:8080/wp-login.php  
https://localhost/wordpress:8443/wp-login.php

To manage your data base (user : "example_user", password : "password") :  
http://localhost:8080/phpmyadmin  
https://localhost:8443/phpmyadmin

List all running containers :
```
docker ps
```
Access a shell inside the container (if only one is running alone) :
```
docker exec -it $(docker ps -q) /bin/sh
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
