#!/bin/bash
#
# Prefight for ceph-deploy

# Functions

function ipvar {
  for i in `seq 1 $1`
    do
      read  -p "Enter ip address of node ${i}: " sshk
      echo -e "Host node${i} \n  Hostname node${i} \n  User $usrn \n" >> $HOME/.ssh/config
      ssh-copy-id ${usrn}@${sshk}
    done
}

# Variables

usrn="root"
release="hammer"
distro="el7"

sfile="${HOME}/ceph-b-deploy/templates/ceph.repo"
dfile="/etc/yum.repos.d/ceph.repo"

# Keygen

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
read  -p "Enter the number of nodes: " nnumb
ipvar $nnumb

cp $sfile $dfile
sed -i "s/{ceph-release}\/{distro}/$release\/$distro/g" $dfile $dfile && yum install -y ceph-deploy
mv $dfile /etc/yum.repos.d/ceph-deploy.repo
