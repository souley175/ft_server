CREATE DATABASE wordpress;
CREATE USER 'souley'@'localhost' IDENTIFIED BY 'souley';
GRANT ALL PRIVILEGES ON wordpress.* TO 'souley'@'localhost'
	IDENTIFIED BY 'souley';
FLUSH PRIVILEGES;
