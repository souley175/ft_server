FROM debian:buster

LABEL MAINTAINER="soukamar alias souley175"

# gestion message d'erreur installation
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# mise a jour 
RUN apt-get update -yq \
&& apt-get install --yes --no-install-recommends apt-utils -yq \
&& apt-get install wget -yq \
&& apt-get install nano -yq \
&& apt-get install curl -yq \
&& apt-get clean -y

# installation phpmyadmin && sql
RUN apt-get install php7.3 php7.3-common php7.3-gd php7.3-mysql php7.3-imap php7.3-cli php7.3-cgi php-pear mcrypt imagemagick libruby php7.3-curl php7.3-intl php7.3-pspell php7.3-recode php7.3-sqlite3 php7.3-tidy php7.3-xmlrpc php7.3-xsl memcached php-memcache php-imagick php-gettext php7.3-zip php7.3-mbstring memcached php7.3-soap php7.3-fpm php7.3-opcache php-apcu -yq \
&& apt-get install mariadb-server -y

# installation serveur nginx
RUN apt-get install nginx -y

# conf mysql
COPY /srcs/doc/table.sql /var/
RUN chmod -R 755 /var/lib/mysql/
RUN /etc/init.d/mysql start
RUN service mysql start && mysql -u root mysql < /var/table.sql

# install phpmyadmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
RUN tar xf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
RUN mv phpMyAdmin-4.9.1-english phpmyadmin
COPY /srcs/doc/config.inc.php phpmyadmin

# conf phpmyadmin

# autoindex test
COPY /srcs/img /var/www/html/img

# telechargement wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN mv latest.tar.gz wordpress.tar.gz && tar -zxvf wordpress.tar.gz && rm -rf wordress.tar.gz

# génération certificats ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=souley175' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
RUN chown -R www-data:www-data *
RUN chmod 755 -R *

# conf wordpress, nginx
COPY /srcs/doc/wp-config.php /var/www/html/wordpress/wp-config.php
COPY /srcs/nginx/default /etc/nginx/sites-available/default

# ajout start.sh
ADD srcs/bash/start.sh /var/

# port 80
EXPOSE 80

# port 443
EXPOSE 443

ENV AUTOINDEX on

CMD bash /var/start.sh 
	
