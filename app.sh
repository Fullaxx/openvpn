#!/bin/bash

bail()
{
  >&2 echo "$1"
  exit 1
}

if [ -d "/profiles" ]; then
  cd /profiles
else
  bail "/profiles does not exist!"
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
