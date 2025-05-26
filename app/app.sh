#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

# Make sure /profiles exists
if [ -d "/profiles" ]; then
  cd /profiles
else
  bail "/profiles does not exist!"
fi

# Make sure we have at least 1 profile
echo "Searching /profiles ..."
PROFILECOUNT=`ls -l *.ovpn | wc -l`
if [ "${PROFILECOUNT}" == "0" ]; then
  bail "${PROFILECOUNT} profiles found!"
fi

# if we are going to use this as a MASQ box, routing must be enabled
if [ "${ENABLEMASQ}" == "1" ]; then
  ENABLEIP4ROUTING="1"
  touch /app/MASQ_ENABLED.flag
fi

# If we need routing, check that it was enabled during container creation
if [ "${ENABLEIP4ROUTING}" == "1" ]; then
  IPFORWARD=`cat /proc/sys/net/ipv4/ip_forward`
  if [ "${IPFORWARD}" != "1" ]; then
    bail "Enable /proc/sys/net/ipv4/ip_forward with --sysctl net.ipv4.ip_forward=1"
  fi
fi

# Launch connect.sh or roundrobin.py
if [ -n "${CONFIGFILE}" ]; then
  echo "CONFIGFILE=${CONFIGFILE}"
  if [ ! -r ${CONFIGFILE} ]; then
    bail "${CONFIGFILE} is not readable under /profiles!"
  fi
  exec /app/connect.sh `pwd`/${CONFIGFILE}
else
  exec /app/roundrobin.py
fi
