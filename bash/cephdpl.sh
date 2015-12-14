#!/bin/bash
#
#

# The main functionality
read  -p "Enter hostname" hnm
osdir = "/var/local/osd"
diro = "/root/mycepho"

mkdir -p $diro && cd $diro

ceph-deploy new $hnm

echo "osd_pool_default_size = 2" >> $diro/ceph.conf

ceph-deploy install $hnm
sleep 2

for i in 0 1 2
  do
    mkdir -p $osdir$i
  done
sleep 2

ceph-deploy mon create-initial
sleep 2

for i in 0 1 2
  do
    ceph-deploy osd prepare $hnm:$osdir$i
    sleep 1
    ceph-deploy osd activate $hnm:$osdir$i
  done
sleep 2

ceph osd tree

