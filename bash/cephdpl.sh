#!/bin/bash
#
#

# Functions
function count {
  for i in `seq 1 $1`
    do
      sleep $1 && echo -n "."
    done
}

function echos {
  echo -e " $1 $2 $3 \n "
}


# Variables

osdir="/var/local/osd"
diro="/root/mycepho"

# Main Functionality

read  -p "Enter the hostname: " hnm

echos Hostname is $hnm

if [[ $(ping -c 1 -q $hnm 2>&1) = "ping: unknown host $hnm" ]]
  then
    echo "Unknown hostname: ${hnm}, Fix the /etc/hosts file" && exit
fi

echos Starting the prefight

sh pre.sh

echos Ceph-deploy diro: $diro
mkdir -p $diro && cd $diro

echos Creating the config
ceph-deploy new $hnm

echo "osd_pool_default_size = 2" >> $diro/ceph.conf && ceph-deploy install $hnm
count 2

echos Create monitor on $hnm
ceph-deploy mon create-initial
count 2
for i in 1 2 3
  do
    echos Preparing $osdir$i
    mkdir -p $osdir$i
    echos Preparing $osdir$i
    ceph-deploy osd prepare $hnm:$osdir$i
    count 2
    echos Activating $osdir$i
    ceph-deploy osd activate $hnm:$osdir$i
    count 2
  done

ceph osd tree
