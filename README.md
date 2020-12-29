# stop nginx
sudo systemctl stop nginx

# construction de l'image docker
sudo docker build -t souley175 .

# lancement de l'image
sudo docker run -it -p 80:80 -p 443:443 souley175 

# lancement img env
sudo docker run --env AUTOINDEX=off -it -p 80:80 -p 443:443 souley175

# lancement image bash
sudo docker run -it souley175 bash

# liste docker
sudo docker ps -a

# clear all docker image
sudo docker system prune

# localhost phpmyadmin
https://localhost/phpmyadmin/
user : souley, mdp : souley

# localhost wordpress
http://127.0.0.1/wordpress/wp-login.php

# localhost test autoindex
http://127.0.0.1/img