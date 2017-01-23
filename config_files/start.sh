#!/usr/bin/env bash

#init db
sed -i "s/{{SQL_USR_PW}}/$SQL_USR_PW/g" /init_db.sql


cd /
rm -rf /config_files_sub
cp -r /config_files /config_files_sub



#configure nginx
echo "configure nginx"
sed -i "s/{{SERVER_NAME}}/$SRV_NAME/g" /config_files_sub/default
cp /config_files_sub/default /etc/nginx/sites-available/default

sed -i "s/{{MYSQL_DB_PW}}/$SQL_USR_PW/g" /config_files_sub/config.local.php
sed -i "s/{{MYSQL_HOST}}/$SQL_HOST/g" /config_files_sub/config.local.php
sed -i "s/{{ADMIN_MAIL}}/$ADMIN_MAIL/g" /config_files_sub/config.local.php
sed -i "s/{{DOMAIN}}/$DOMAIN/g" /config_files_sub/config.local.php
sed -i "s/{{SMTP_SERVER}}/$SMTP_SERVER/g" /config_files_sub/config.local.php
sed -i "s/{{FQDN}}/$FQDN/g" /config_files_sub/config.local.php


RND=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-24};echo;)
MD5SALT=$(echo -n $RND | md5sum)
SALT=${MD5SALT:0:-3}

echo "SALT:${SALT}|END"

TEST=$(echo -n "${SALT}:${SETUP_PW}" | sha1sum)
SETUP_HASH_1=${TEST:0:-3}
echo "HASHED PW WITH SALT:${SETUP_HASH_1}|END"
SETUP_HASH=${SALT}:${SETUP_HASH_1}
echo "SETUP_HASH:${SETUP_HASH}|END"
sed -i "s/{{SETUP_HASH}}/$SETUP_HASH/g" /config_files_sub/config.local.php

cp /config_files_sub/config.local.php /var/www/html/config.local.php

chown -R www-data:www-data /var/www
chmod -R g+w /var/www/html

#wait for database to start up
echo "wait for database"
while !(mysqladmin -h $SQL_HOST -u $SQL_USER -p$SQL_PW ping)
do
    sleep 1
done
echo "database on"

service nginx start
service nginx reload
service php7.0-fpm start

#if this is the first run we need to setup tables etc.

echo "initalize database:"
mysql -u root -p$SQL_PW -h $SQL_HOST 'root' < init_db.sql


/bin/bash

tail -f /dev/null