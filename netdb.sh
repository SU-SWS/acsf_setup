#!/bin/bash
read -p "Enter the site shortname on ACSF (e.g., \"opinion\"; no quotes): " acsfshortname
read -p "Enter the stanford.edu hostname you would like to register in NetDB (e.g., \"opinion\"; no quotes): " hostname
netdb node clone --template acsf.cardinalsites.acsitefactory.com --name "$acsfshortname".cardinalsites.acsitefactory.com
netdb node alias --add "$hostname" "$acsfshortname".cardinalsites.acsitefactory.com
netdb node info "$acsfshortname".cardinalsites.acsitefactory.com
printf "\n"
echo "Done."
printf "\n"
