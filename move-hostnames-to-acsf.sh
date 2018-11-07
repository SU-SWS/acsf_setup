#!/bin/bash

hostnames=$1
if [ -z $hostnames ]; then
  read -p "Enter the name of the file that holds the hostnames: " hostnames
fi

if [ ! -f $hostnames ]; then
  echo "You didn't provide a valid hostnames file"
fi

while read acsfshortname hostname; do
  printf "\n"
  echo "The file we are using is "$hostnames
  printf "\n"
  printf "\n"
  echo "The vhost we are moving is "$hostname
  printf "\n"
  printf "\n"
  echo "The short name of the site on ACSF is "$acsfshortname
  netdb node alias --remove $hostname sites-lb
  printf "\n"
  echo $hostname" was removed from sites-lb (unless you see an error above)."
  printf "\n"
  netdb node clone --template acsf.cardinalsites.acsitefactory.com --name $acsfshortname".cardinalsites.acsitefactory.com"
  printf "\n"
  echo "A node for "$acsfshortname".cardinalsites.acsitefactory.com was created in NetDB (unless you see an error above)."
  printf "\n"
  sleep 15
  netdb node alias --add $hostname $acsfshortname".cardinalsites.acsitefactory.com"
  printf "\n"
  echo $hostname".stanford.edu was added as an alias in NetDB for "$acsfshortname".cardinalsites.acsitefactory.com (unless you see an error above)."
  printf "\n"
  netdb node info $acsfshortname".cardinalsites.acsitefactory.com"
  printf "\n"
  echo "We're done here."
  printf "\n"
done <  $hostnames
