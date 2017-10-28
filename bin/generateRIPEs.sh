#!/bin/sh -x

if [ -d "../data" ]
  then echo -n ""
  else exit 1
fi

# z tehoto treba spravit (dvojdimenzionalny?) array, kery bude mat ako druhy parameter URL na tahanie a nie takyto bordel!
# alternativne dva arraye.

ipv6assignments="ipv6-unicast-address-assignments.csv"
ipv4assignments="ipv4-address-space.csv"
ipv6assignmissing=0
ipv4assignmissing=0

for assignments in "$ipv6assignments" "$ipv4assignments"
do \
  if [ -f "../data/$assignments" ]
  then \
    echo "$assignments already loaded"
  else \
    if [ ! -f "../data/$ipv4assignments" ]
    then \
      ipv4assignmissing=1
    fi
    if [ ! -f "../data/$ipv6assignments" ]
    then \
      ipv6assignmissing=1
    fi
  fi
done

if [ $ipv4assignmissing -eq 1 ]
then \
  wget -c "https://www.iana.org/assignments/ipv4-address-space/$ipv4assignments" -O "../data/$ipv4assignments"
fi
if [ $ipv6assignmissing -eq 1 ]
then \
  wget -c "https://www.iana.org/assignments/ipv6-unicast-address-assignments/$ipv6assignments" -O "../data/$ipv6assignments"
fi

grep "RIPE NCC" "../data/$ipv6assignments" | grep "ALLOCATED" | awk -F',' '{print $1}' > ../tables/RIPEv6.txt
grep "RIPE NCC" "../data/$ipv4assignments" | grep "ALLOCATED" | awk -F',' '{print $1}' > ../tables/RIPEv4.txt
