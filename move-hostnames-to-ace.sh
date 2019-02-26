#!/bin/bash

hostnames=$1
if [ -z $hostnames ]; then
  read -p "Enter the name of the file that holds the hostnames: " hostnames
fi

if [ ! -f $hostnames ]; then
  echo "You didn't provide a valid hostnames file"
fi

while read aceshortname hostname; do
  printf "\n" >> move-hostnames-to-ace.log
  echo "The file we are using is "$hostnames >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
  echo "The vhost we are moving is "$hostname >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
  echo "The short name of the site on ACE is "$aceshortname >> move-hostnames-to-ace.log
  netdb node alias --remove $hostname sites-lb 1>> move-hostnames-to-ace.log 2>> errors.log
  printf "\n" >> move-hostnames-to-ace.log
  echo $hostname" was removed from sites-lb (unless you see an error above)." >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
  netdb node alias --add $hostname hs-mrc-prod
  printf "\n" >> move-hostnames-to-ace.log
  echo "A node for "$aceshortname".cardinalsites.acsitefactory.com was created in NetDB (unless you see an error above)." >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
  sleep 15 
  echo "$hostname.stanford.edu was added as an alias in NetDB for \"hs-mrc-prod\"(unless you see an error above)." >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
  netdb node info "$hostname.stanford.edu"  1>> move-hostnames-to-ace.log 2>> errors.log
  printf "\n" >> move-hostnames-to-ace.log
  echo "We're done here." >> move-hostnames-to-ace.log
  printf "\n" >> move-hostnames-to-ace.log
done <  $hostnames
