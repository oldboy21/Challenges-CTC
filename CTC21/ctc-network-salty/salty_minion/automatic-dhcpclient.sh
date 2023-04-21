#!/bin/bash
counter=0 

if [ -e /sys/class/net/c_y_eth0 ]; then
        ETHDEV=c_y_eth0
else
        ETHDEV=eth0
fi

while true
do 
   sleep 10
   dhclient $ETHDEV
   echo $counter
   if [ "$counter" -eq 5 ] 
   then
      echo $counter
      pkill -f dhclient
      counter=0
   fi
   counter=$((counter+1))
done 
