#!/usr/bin/env bash

docker run -d --rm --security-opt label=disable -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_HOST_AUTH_METHOD=trust --name postgres -v /home/imerk/postgres/data:/var/lib/postgresql/data postgres:latest
