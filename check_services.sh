#!/bin/bash

NOW=$(date '+%Y-%m-%d %H:%M:%S')

if [ "$#" -eq 0 ]; then
  echo "Usage: ./check_services.sh <service1> <service2> ..."
  exit 1
fi

for svc in "$@"; do
  if systemctl is-active --quiet $svc; then
    echo "$svc : Запущен"
  else
    echo "$NOW - $svc: Не запущен" >> /var/log/check_services.log
  fi
done
