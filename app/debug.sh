#!/bin/bash

ls -l /app/MASQ_ENABLED.flag

echo -n "/proc/sys/net/ipv4/ip_forward: "
cat /proc/sys/net/ipv4/ip_forward

ip addr show
ip route show

iptables -nvL -t nat

echo -n "www.icanhazip.com: "
curl https://www.icanhazip.com

echo -n "ipv4.icanhazip.com: "
curl https://ipv4.icanhazip.com

echo -n "ipv6.icanhazip.com: "
curl https://ipv6.icanhazip.com

echo -n "ifconfig.me: "
curl https://ifconfig.me
