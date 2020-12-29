#!/bin/sh

echo ""
echo -e "**** \e[1mSouley175 START SERVER \e[0m****"
echo ""
if [[ $AUTOINDEX = "on" ]]
then
  echo -e "Setting Nginx autoindexing to \e[92mon\e[0m "
else
  echo -e "Setting Nginx autoindexing to \e[91moff\e[0m "
fi

sed -i "s/\$AUTOINDEX/$AUTOINDEX/" /etc/nginx/sites-available/default

service mysql start
service php7.3-fpm start
service nginx start
while true;
	do sleep 10000;
done
