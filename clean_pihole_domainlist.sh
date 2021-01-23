#!/bin/bash
/usr/bin/sqlite3 docker_data/volumes/pi_hole/etc-pihole/gravity.db "delete from domainlist"
