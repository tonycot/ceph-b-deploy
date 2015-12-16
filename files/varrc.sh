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
srn="root"
release="hammer"
distro="el7"
