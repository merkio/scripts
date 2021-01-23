#!/usr/bin/env bash

docker run  -d --rm -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=password mysql:latest
