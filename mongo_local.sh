#!/usr/bin/env bash
docker run -d --rm --name mongo -p 27017:27017 --privileged -v /home/imerk/mongodb/data:/data/db mvertes/alpine-mongo
