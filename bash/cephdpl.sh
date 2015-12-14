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
log="$diro/logs"

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
mkdir -p $diro $log && cd $diro

echos Creating the config
ceph-deploy new $hnm > $log/cdep.log

echo "osd_pool_default_size = 2" >> $diro/ceph.conf && ceph-deploy install $hnm >> $log/cdep.log
count 2

exit
for i in 0 1 2
  do
    echos Creating $osdir$i
    mkdir -p $osdir$i
  done
count 2

ceph-deploy mon create-initial > $log/mncrt.log
count 2

for i in 0 1 2
  do
    echos Preparing $osdir$i
    ceph-deploy osd prepare $hnm:$osdir$i > $log/osdp${i}.log
    count 1
    echos Preparing $osdir$i
    ceph-deploy osd activate $hnm:$osdir$i > $log/osdc${i}.log
  done
count 2

ceph osd tree

