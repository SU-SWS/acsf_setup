#!/bin/bash
while read hostname acsfshortname; do
#  netdb node alias --remove $hostname sites-lb
  netdb node clone --template acsf.cardinalsites.acsitefactory.com --name "$acsfshortname".cardinalsites.acsitefactory.com
  netdb node alias --add "$hostname" "$acsfshortname".cardinalsites.acsitefactory.com
  netdb node info "$acsfshortname".cardinalsites.acsitefactory.com
  printf "\n"
  echo "Done."
  printf "\n"
done <  hostnames.txt
