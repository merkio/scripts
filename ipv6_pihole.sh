# enable ipv6 in dockerd conf:

# cat /etc/docker/daemon.json
{
  "ipv6": true,
  "fixed-cidr-v6": "2003::/64" # your ipv6. not sure if this is even necessary 
}

# reload daemon conf:
sudo systemctl reload docker.service

# check it loaded okay
sudo systemctl status docker.service

# create ipv6 enabled network
docker network create --ipv6 --driver bridge --subnet "fd01::/64" ipv6


# if you have an existing container:

docker network connect ipv6 pihole
docker network disconnect bridge pihole
docker restart pihole

# modify setupvar.conf:
# cat etc-pihole/setupVars.conf | grep IP
DHCP_IPv6=true
IPV4_ADDRESS=192.168.1.2                    # Docker Host IP
IPV6_ADDRESS=fd00::1111:1111:1111:1111      # Docker Host IPv6

# restart pihole dns
docker exec -it pihole /bin/bash -c 'pihole restartdns'

# updated docker run command
# not tested because I used portainer to modify ENV Variables!

docker run -d \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 9000:80 \
    -p 9001:443 \
    -e TZ="Europe/Berlin" \
    -e ServerIPv6="fd00::1111:1111:1111:1111" \
    -e IPv6="true" \
    -v "$(pwd)/etc-pihole/:/etc/pihole/" \
    -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --restart=unless-stopped \
    --network=ipv6 \
    pihole/pihole:latest


# To verify:
dig AAAA heise.de -6 @pihole

# from pihole -t in container
13:30:57 dnsmasq[1137]: query[AAAA] pihole from 172.20.0.1
13:30:57 dnsmasq[1137]: /etc/pihole/local.list pihole is fd00::1111:1111:1111:1111
13:30:57 dnsmasq[1137]: query[AAAA] heise.de from 172.20.0.1
13:30:57 dnsmasq[1137]: cached heise.de is 2a02:2e0:3fe:1001:302::
