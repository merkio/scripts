!#/bin/bash

docker run --rm --name=gogs -d -p 10022:22 -p 3000:3000 -v /docker_data/volumes/gogs:/data gogs/gogs-rpi
