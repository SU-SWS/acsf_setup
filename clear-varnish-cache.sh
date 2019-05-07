#!/bin/bash
if [ -z $1 ]; then
  read -p "Enter the short name of the site on ACSF (e.g., \"cas\", no quotes): " acsf_short_name
else
  acsf_short_name=$1
fi

if [ -z $2 ]; then
  read -p "Enter the site URL (e.g., \"mindovermoney.stanford.edu\", no quotes and no \"https://\"): " hostname
else
  hostname=$2
fi

# See https://docs.acquia.com/acquia-cloud/performance/varnish/manually-purge/
curl -k -X PURGE -H "X-Acquia-Purge: $acsf_short_name" --compress -H "Host: $hostname" https://bal-2136.enterprise-g1.hosting.acquia.com/
