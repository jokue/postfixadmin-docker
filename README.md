# POSTFIXADMIN DOCKER

##### RUN:
```
docker run -i -t \
	-p 80:80 \
	--network="nginx-proxy" \
	-e SQL_USER=root \
	-e SQL_PW=my-root-password \
	-e SQL_USR_PW=my-vmail-database-pw \
	-e SQL_HOST= mydb \
	-e ADMIN_MAIL=postmaster@example.com \
	-e DOMAIN=example.com \
	-e FQDN=mail.example.com \
	-e SMTP_SERVER=smtp.example.com \
	-e SETUP_PW="SETUP_PW"
	 number13/postfixadmin
```


visit: example.com/setup.php and create an Admin Account. --> You're done.

##### Environment Variables

###### SQL_USER

The SQL User which has access to the MySQL for the database: `postfix`

###### SQL_PW

The SQL User Password

###### SQL_HOST

The SQL Host - e.g. if youre using a network bridge the name of your SQL-Container

###### ADMIN_MAIL

An administrator email for postfixadmin - not necessarily needed

###### DOMAIN

the Domain under which your postboxed: postmaster@domain.tld / hostmaster@domain.tld etc. reside

###### FQDN

Your FQDN for sending E-Mails from this Server

###### SMTP_SERVER

The SMTP Server to use for sending mails

###### SETUP_PW

The Postfixadmin Setup Pw - you can generate Admin Users with this Password @ domain.tld/setup.php
