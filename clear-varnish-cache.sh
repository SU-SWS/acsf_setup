#!/bin/bash
read -p "Enter the site URL (e.g., \"mindovermoney.stanford.edu\", no quotes and no \"https://\"): " hostname

curl -k -X PURGE -H "X-Acquia-Purge:mysite" --compress -H "Host: $hostname" https://cardinald702live.enterprise-g1.acquia-sites.com/
