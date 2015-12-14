#!/bin/bash
#
# Prefight for ceph-deploy

release="hammer"
distro="el7"

sfile="${HOME}/ceph-b-deploy/templates/ceph.repo"
dfile="/etc/yum.repos.d/ceph.repo"

cp $sfile $dfile
sed -i "s/{ceph-release}\/{distro}/$release\/$distro/g" $dfile $dfile && yum install -y ceph-deploy
mv $dfile /etc/yum.repos.d/ceph-deploy.repo
