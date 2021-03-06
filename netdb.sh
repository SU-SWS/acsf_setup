#!/bin/bash
read -p "Enter the site shortname on ACSF (e.g., \"opinion\"; no quotes): " acsfshortname
read -p "Enter the stanford.edu hostname you would like to register in NetDB (e.g., \"opinion\"; no quotes): " hostname
#netdb domain delete "$hostname".stanford.edu
netdb node clone --template acsf.cardinalsites.acsitefactory.com --name "$acsfshortname".cardinalsites.acsitefactory.com
netdb node alias --add "$hostname" "$acsfshortname".cardinalsites.acsitefactory.com
netdb node info "$acsfshortname".cardinalsites.acsitefactory.com
siteid=`drush @acsf.cardinald7.$acsfshortname vget --exact --format=string acsf_site_id`
# Sleep 30 minutes. Then set acsf_helper_canonical_url to <hostname>.stanford.edu. Then clear the Varnish cache.
sleep 30m && drush @acsf.cardinald7.$acsfshortname vset --exact acsf_helper_canonical_url $hostname.stanford.edu && \
  curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$siteid/cache-clear" \
  -X POST -H 'Content-Type: application/json' \
  -v -u "$ACSF_USERNAME":"$ACSF_API_KEY" &
printf "\n"
echo "$acsfshortname.cardinalsites.acsitefactory.com was created as a node in NetDB."
printf "\n"
echo "$hostname.stanford.edu was added as an alias on $acsfshortname.cardinalsites.acsitefactory.com."
printf "\n"
echo "The acsf_helper_canonical_url variable on $acsfshortname was set to $hostname.stanford.edu, forcing loading through that URL."
printf "\n"
echo "Wait up to 30 minutes for DNS to refresh (at :05 and :35 past the hour)."
printf "\n"
echo "Done."
printf "\n"
