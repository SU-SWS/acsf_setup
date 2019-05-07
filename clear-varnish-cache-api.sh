#!/bin/bash
if [ -z $1 ]; then
  read -p "Enter the short name of the site on ACSF (e.g., \"cas\", no quotes): " acsf_short_name
else
  acsf_short_name=$1
fi

echo "Starting..."
siteid=`drush @acsf.cardinald7.$acsf_short_name vget --exact --format=string acsf_site_id`
    curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$siteid/cache-clear" \
    -X POST -H 'Content-Type: application/json' \
    -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"
printf "\nFinished.\n"
