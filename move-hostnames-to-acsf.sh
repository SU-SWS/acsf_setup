#!/bin/bash

hostnames=$1
if [ -z $hostnames ]; then
  read -p "Enter the name of the file that holds the hostnames: " hostnames
fi

if [ ! -f $hostnames ]; then
  echo "You didn't provide a valid hostnames file"
fi

while read acsfshortname hostname; do
  printf "\n" >> move-hostnames-to-acsf.log
  echo "The file we are using is "$hostnames >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo "The vhost we are moving is "$hostname >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo "The short name of the site on ACSF is "$acsfshortname >> move-hostnames-to-acsf.log
  netdb node alias --remove $hostname sites-lb 1>> move-hostnames-to-acsf.log 2>> errors.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo $hostname" was removed from sites-lb (unless you see an error above)." >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
  netdb node clone --template acsf.cardinalsites.acsitefactory.com --name $acsfshortname".cardinalsites.acsitefactory.com" 1>> move-hostnames-to-acsf.log 2>> errors.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo "A node for "$acsfshortname".cardinalsites.acsitefactory.com was created in NetDB (unless you see an error above)." >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
  sleep 15 >> move-hostnames-to-acsf.log
  netdb node alias --add $hostname $acsfshortname".cardinalsites.acsitefactory.com" 1>> move-hostnames-to-acsf.log 2>> errors.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo $hostname".stanford.edu was added as an alias in NetDB for "$acsfshortname".cardinalsites.acsitefactory.com (unless you see an error above)." >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
  netdb node info $acsfshortname".cardinalsites.acsitefactory.com"  1>> move-hostnames-to-acsf.log 2>> errors.log
  printf "\n" >> move-hostnames-to-acsf.log
  echo "We're done here." >> move-hostnames-to-acsf.log
  printf "\n" >> move-hostnames-to-acsf.log
done <  $hostnames
