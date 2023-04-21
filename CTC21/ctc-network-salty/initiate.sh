#!/bin/bash

if [ -z "$1" ]
then 
    echo "Missing argument: IP of master"
    exit 1
fi

# set te IP in the dhcp-parse.sh and ini the nsenter command 
echo "Building docker images"
masterip=$1
sed -i 's/MASTER-IP/'$masterip'/' minion/dhcp-parse.sh


docker build --no-cache -t ubuntu-dhcp dhcp-server-master/
docker build --no-cache -t ubuntu-dhcp-minion minion/

echo "Running containers"
docker run --name container_x --privileged -d ubuntu-dhcp
docker run --net=none --name container_y --privileged -d ubuntu-dhcp-minion

echo "Creating and assigning veth interfaces"
ip link add c_x_eth0 type veth peer name c_y_eth0
DOCKERPIDX=$(docker inspect --format '{{.State.Pid}}' container_x)
DOCKERPIDY=$(docker inspect --format '{{.State.Pid}}' container_y)

echo "Printing the PIDs "
echo "${DOCKERPIDX}"
echo "${DOCKERPIDY}"

ip link set netns "${DOCKERPIDX}" dev c_x_eth0
ip link set netns "${DOCKERPIDY}" dev c_y_eth0
nsenter -t "${DOCKERPIDX}" -n ip link set c_x_eth0 up
nsenter -t "${DOCKERPIDY}" -n ip link set c_y_eth0 up

echo "Assigning IP address to the DHCP server container"
nsenter -t "${DOCKERPIDX}" -n ip addr add "${masterip}"/24 dev c_x_eth0

CONTAINERXID=$(docker ps | grep container_x | cut -d " " -f 1)
CONTAINERXIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINERXID) 
echo "Start the challenge connecting via SSH to" $CONTAINERXIP
