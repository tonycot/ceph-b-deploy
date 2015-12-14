#!/usr/bin/env bash
#
#

#Dirs
osdir="/var/local/osd"
diro="/root/mycepho"

# Files 
sfile="${HOME}/ceph-b-deploy/templates/ceph.repo"
dfile="/etc/yum.repos.d/ceph.repo"
nodefile="nodes.txt"

# Variables
usrn="root"
release="hammer"
distro="el7"
hnm=` cat $diro/$nodefile `
