#!/bin/bash

#| Option                 | What It Does                                                     |
#| ---------------------- | ---------------------------------------------------------------- |
#| `resolv-retry 0`       | Disables repeated DNS resolution attempts.                       |
#| `connect-retry 1 1`    | Try connecting only **once**, with a 1-second delay.             |
#| `connect-timeout 10`   | Wait up to 10 seconds during connection attempts before failing. |
#| `explicit-exit-notify` | Notifies the server on exit (especially useful with UDP).        |

# --daemon --log /var/log/openvpn/openvpn.log

if [ -z "$1" ]; then
  >&2 echo "$0: <CONFIGFILE>"
  exit 1
fi

openvpn --config $1 \
  --resolv-retry 0 \
  --connect-retry 1 1 \
  --connect-timeout 10 \
  --explicit-exit-notify \
  --script-security 2 --up /app/up.sh --down /app/down.sh
