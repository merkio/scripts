#!/bin/bash

docker run --name mariadb --rm -v /home/pi/docker_data/volumes/db-data/etc/mysql:/etc/mysql -v db-data:/var/lib/mysql -p 3306:3306 -e MYSQL_DATABASE=root -e MYSQL_ROOT_PASSWORD=password -d arm64v8/mariadb:latest
