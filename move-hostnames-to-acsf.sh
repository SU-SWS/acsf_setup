#!/bin/bash

hostnames=$1
if [ -z $hostnames ]; then
  read -p "Enter the name of the file that holds the hostnames: " hostnames
fi

if [ ! -f $hostnames ]; then
  echo "You didn't provide a valid hostnames file"
fi

while read acsfshortname hostname; do
#  netdb node alias --remove $hostname sites-lb
#  netdb node clone --template acsf.cardinalsites.acsitefactory.com --name $acsfshortname".cardinalsites.acsitefactory.com"
#  sleep 15
#  netdb node alias --add $hostname $acsfshortname".cardinalsites.acsitefactory.com"
#  netdb node info $acsfshortname".cardinalsites.acsitefactory.com"
  echo $hostnames
  echo $hostname
  echo $acsfshortname
  printf "\n"
  echo "Done."
  printf "\n"
done <  hostnames.txt
