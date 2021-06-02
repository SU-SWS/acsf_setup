#!/bin/bash
read -p "Enter the D7 site shortname on ACSF (e.g., \"opinion\"; no quotes): " acsfd7shortname
read -p "Enter the D8 site shortname on ACSF (e.g., \"opinion\"; no quotes): " acsfd8shortname
read -p "Enter the stanford.edu hostname assigned to the D7 site (e.g., \"opinion\"; no quotes): " hostname
read -p "Enter the ACSF site id of the D7 site (e.g., \"1234\"; no quotes): " acsfd7siteid
read -p "Enter the ACSF site id of the D8 site (e.g., \"5678\"; no quotes): " acsfd8siteid
netdb node name --add $acsfd8shortname.cardinalsites.acsitefactory.com --remove $acsfd7shortname.cardinalsites.acsitefactory.com $acsfd7shortname.cardinalsites.acsitefactory.com
netdb node info "$hostname"

curl "https://www.cardinalsites.acsitefactory.com/api/v1/domains/$acsfd7siteid/remove" \
-X POST -H 'Content-Type: application/json' \
-d '{"domain_name": "'$hostname'.stanford.edu" }' \
-v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

curl "https://www.cardinalsites.acsitefactory.com/api/v1/domains/$acsfd8siteid/add" \
-X POST -H 'Content-Type: application/json' \
-d '{"domain_name": "'$hostname'.stanford.edu" }' \
-v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$acsfd8siteid/cache-clear" \
-X POST -H 'Content-Type: application/json' \
-v -u "$ACSF_USERNAME":"$ACSF_API_KEY" &

curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$acsfd7siteid/cache-clear" \
-X POST -H 'Content-Type: application/json' \
-v -u "$ACSF_USERNAME":"$ACSF_API_KEY" &

printf "\n"
echo "Done."
printf "\n"
