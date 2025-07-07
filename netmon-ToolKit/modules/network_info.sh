#!/bin/bash
echo "== Network Interfaces =="
ip addr

echo -e "\n== Routing Table =="
ip route

echo -e "\n== DNS Resolvers =="
cat /etc/resolv.conf

