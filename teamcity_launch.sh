#!/usr/bin/env bash
docker run -it --name teamcity-server-instance  \
    -v /home/ishaman/teamcity/datadir:/data/teamcity_server/datadir \
    -v /home/ishaman/teamcity/logs:/opt/teamcity/logs  \
    -p 8111:8111 \
    jetbrains/teamcity-server
