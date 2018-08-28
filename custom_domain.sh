#!/bin/bash
read -p "Enter the numeric site_id from ACSF (e.g., \"375\"; no quotes): " siteid
read -p "Enter the stanford.edu hostname you would like to add as a custom domain in ACSF (e.g., \"opinion\"; no quotes): " hostname
      curl "https://www.cardinalsites.acsitefactory.com/api/v1/domains/$siteid/add" \
    -X POST -H 'Content-Type: application/json' \
    -d '{"domain_name": "'$hostname'.stanford.edu" }' \
    -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"
