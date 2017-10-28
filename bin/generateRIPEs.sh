#!/bin/sh -x

if [ -d "../data" ]
  then echo -n ""
  else exit 1
fi

if [ -f "../data/ipv6-unicast-address-assignments.csv" ]
  then echo "ipv6-unicast-address-assignments.csv already loaded"
  else wget -c "https://www.iana.org/assignments/ipv6-unicast-address-assignments/ipv6-unicast-address-assignments.csv" -O "../data/ipv6-unicast-address-assignments.csv"
fi

grep "RIPE NCC" "../data/ipv6-unicast-address-assignments.csv" | grep "ALLOCATED" | awk -F',' '{print $1}'
