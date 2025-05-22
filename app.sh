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

if [ -n "${CONFIGFILE}" ]; then
  echo "CONFIGFILE=${CONFIGFILE}"
  if [ ! -r ${CONFIGFILE} ]; then
    bail "${CONFIGFILE} is not readable under /profiles!"
  fi
  exec /app/connect.sh `pwd`/${CONFIGFILE}
else
  exec /app/roundrobin.py
fi
