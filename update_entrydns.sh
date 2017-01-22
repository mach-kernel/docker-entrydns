#!/bin/sh

[ -z "${AUTH_TOKEN}" ] && { echo "=> AUTH_TOKEN cannot be empty" && exit 1; }

IPADDRESS=`curl -s icanhazip.com`
if [[ "${IPADDRESS}" != "$(cat /current_ip)" ]]; then
  echo "IP does not match, updating DNS"
  echo ${IPADDRESS} >|/current_ip
  curl -k -X PUT -d "ip=${IPADDRESS}" "https://entrydns.net/records/modify/${AUTH_TOKEN}"
fi

echo "DNS record is up to date"