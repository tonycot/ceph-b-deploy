#!/usr/bin/env bash
#
#

# Include variables and functions
source ../files/varrc.sh
source ../files/func.sh


# Main Functionality

read  -p "Enter the hostname: " hust

echos Hostname is $hust

if [[ $(ping -c 1 -q $hust 2>&1) = "ping: unknown host $hnm" ]]
  then
    echo "Unknown hostname: ${hust}, Fix the /etc/hosts file" && exit
fi

echos Starting the prefight

sh pre.sh

echos Ceph-deploy diro: $diro
cd $diro

echos Creating the config

# to do
ceph-deploy new $hnm

# to do

echo "osd_pool_default_size = 2" >> $diro/ceph.conf && ceph-deploy install $hnm
count 2

echos Create initial monitor
ceph-deploy mon create-initial
count 2

for i in 0 1 2
  do
    for k in $hnm
      do
        echos Preparing $k:$osdir$i
        mkdir -p $k:$osdir$i
        echos Preparing $k:$osdir$i
        ceph-deploy osd prepare $k:$osdir$i
        sleep 4
        echos Activating $k:$osdir$i
        ceph-deploy osd activate $k:$osdir$i
        sleep 4
      done
  done

ceph osd tree
