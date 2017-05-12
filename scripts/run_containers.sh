#!/bin/bash

docker run -d --name mysql -p 3306:3306 -v /data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=0901 xiao/mysql
docker run -d --name php -v /data/www:/data/www --link mysql:mysql xiao/php
docker run -d --name nginx -p 80:80 -v /data/www/:/data/www/ --link php:php xiao/nginx
