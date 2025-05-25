#!/bin/bash
# /app/down.sh tun0 1500 0 10.14.202.14 255.255.255.0 init

if [ -f /app/MASQ_ENABLED.flag ]; then
  MASQDEV="$1"
  CMD="iptables -t nat -D POSTROUTING -o ${MASQDEV} -j MASQUERADE"
  echo ${CMD}
  ${CMD}
fi
