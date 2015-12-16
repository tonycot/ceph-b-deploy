#!/usr/bin/env bash
#
# Prefight for ceph-deploy

# Including variables and functions


source ../files/varrc.sh
source ../files/func.sh

# Ceph dir preparation
mkdir -p $diro

# Keygen
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
read  -p "Enter the number of nodes: " nnumb
ipvar $nnumb

cp $sfile $dfile
sed -i "s/{ceph-release}\/{distro}/$release\/$distro/g" $dfile $dfile && yum install -y ceph-deploy
mv $dfile /etc/yum.repos.d/ceph-deploy.repo
