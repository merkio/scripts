#!/bin/bash

docker network create -d macvlan \
  --ipv6 \
  --subnet=192.168.0.0/24 \
  --gateway=192.168.0.1 \
  --ip-range 192.168.0.2/27 \
  --aux-address 'host=192.168.0.220'
  --subnet=2a02:8109:98c0:6f3c::/64 \
  -o parent=eth0 public_net
