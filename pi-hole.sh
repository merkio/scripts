#!/bin/bash

# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

PIHOLE_BASE="$(pwd)/docker_data/volumes/pi_hole"
[[ -d "$PIHOLE_BASE" ]] || mkdir -p "$PIHOLE_BASE" || { echo "Couldn't create storage directory: $PIHOLE_BASE"; exit 1; }

# Note: ServerIP should be replaced with your external ip.
docker run -d \
    --rm \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 8089:80 \
    -p 8443:443 \
    -e TZ="Europe/Berlin" \
    -v "${PIHOLE_BASE}/etc-pihole/:/etc/pihole/" \
    -v "${PIHOLE_BASE}/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --hostname pi.hole \
    -e VIRTUAL_HOST="pi.hole" \
    -e PROXY_LOCATION="pi.hole" \
    -e ServerIP="192.168.0.X" \
    -e ServerIPv6="9ce:4745" \
    -e IPv6="true" \
    -e RESOLVE_IPV6="yes" \
    --cap-add NET_ADMIN \
    -e DNSMASQ_LISTENING="all" \
    pihole/pihole:latest

printf 'Starting up pihole container '
for i in $(seq 1 20); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
        printf ' OK'
        echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: https://${IP}/admin/"
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ $i -eq 20 ] ; then
        echo -e "\nTimed out waiting for Pi-hole start, consult your container logs for more info (\`docker logs pihole\`)"
        exit 1
    fi
done;
