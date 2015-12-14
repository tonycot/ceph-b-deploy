#!/usr/bin/env bash
#
#

# Functions

#IP address counter
function ipvar {
  for i in `seq 1 $1`
    do
      read  -p "Enter the ip address of node ${i}: " sshk
      echo -e "Host node${i} \n  Hostname ${sshk} \n  User $usrn \n" >> $HOME/.ssh/config
      echo -e "node${i} \n " >> $diro/$nodefile
      ssh-copy-id ${usrn}@${sshk}
    done
    
}


# Simple counter
function count {
  for i in `seq 1 $1`
    do
      sleep 1 && echo -n "."
    done
  echo -e " \n "
}

# Simple printing
function echos {
  echo -e " $1 $2 $3 \n "
}

function count {
  for i in `seq 1 $nnumb`
    do
      echo node${i} >> /   
    done
}
