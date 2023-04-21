#!/bin/bash
sleep 5

if [ -e /sys/class/net/c_y_eth0 ]; then
        ETHDEV=c_y_eth0
else
        ETHDEV=eth0
fi

tcpdump -vv -l -i $ETHDEV | while read b; do  
   dnsip=$(echo $b | grep -i 'Domain-Name-Server' | grep -vi 'hostname' | cut -d ":" -f 2)
   if [ ! -z "$dnsip" ]
   then
      echo $dnsip
      if [ "$dnsip" == " 10.6.0.2" ]; then 
           echo "Correct dns set"
           echo "$(sed '2,$c search home\nnameserver '"$dnsip"'' /etc/resolv.conf)" > /etc/resolv.conf
      fi
   fi
done
