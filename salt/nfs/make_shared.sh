#!/bin/bash
set -e

loc=$1
rem=$2

if [[ ! -h $loc ]]; then
  mkdir -p $rem
  rm -rf $loc
  ln -s $rem $loc
  
  echo "changed=yes comment='Link has been created'"
fi
