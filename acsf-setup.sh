#!/bin/bash
echo "$ACSF_USERNAME"
echo $ACSF_API_KEY
read -p "Is this site for a student group? (Y/N): " studentgroup
read -p "Enter the \"Website address\" from the SNOW request (e.g., \"appliedmetaphysics\"): " sitename
read -p "Enter the \"Website Title\" from the SNOW request (e.g., \"Department of Applied Metaphysics\"): " sitetitle
read -p "Enter the requester's SUNetID (e.g., \"ahislop\"): " sunetid
read -p "Enter the requester's Full Name from the SNOW request (e.g., \"Alyssa Hislop\"): " fullname
read -p "Enter the numeric site_id that was returned from the Acquia API (e.g., \"1081\"): " siteid
read -p "Did the requester specify an additional owner? (Y/N): " additionalowner
if test $additionalowner = Y; then
  read -p "Enter the addtional owner's SUNetID (e.g., \"jbickar\"): " additionalownersunetid
  read -p "Enter the additional owner's Full Name from the SNOW request (e.g., \"John Bickar\"): " additionalownerfullname
fi

# Confirmation
printf "\n"
printf "\n"
echo "########################"
if test $studentgroup = Y; then
  echo "This site is for a student group and will get the \"Stanford Light\" theme"
else
  echo "This site is NOT for a student group and will get the \"Stanford Framework\" theme"
fi
echo "The site's short name is: "$sitename
echo "The site's title is: "$sitetitle
echo "The requester's SUNetID is: "$sunetid
echo "The requester's Full Name is: "$fullname
if test $additionalowner = Y; then
  echo "The additional owner's SUNetID is: "$additionalownersunetid
  echo "The additional owner's Full Name is: "$additionalownerfullname
else
  echo "There are no additional owners."
fi
echo "########################"
printf "\n"
printf "\n"
read -p "Are you ready to proceed? (Y/N): " ready
if test $ready = Y; then
  read -p "There is no undo. Are you sure you are ready to proceed? (Y/N): " reallyready
  if test $reallyready = Y; then
    if test $studentgroup = Y; then
      drush @acsf.cardinald7.$sitename -y si stanford
    fi

    drush @acsf.cardinald7.$sitename ssp-au $sunetid --name="$fullname"
    drush @acsf.cardinald7.$sitename -y vset site_name "$sitetitle"
    # Add an ACSF API call to create the custom domain. Use environment variables to authenticate against the API.
      curl "https://www.cardinalsites.acsitefactory.com/api/v1/domains/$siteid/add" \
    -X POST -H 'Content-Type: application/json' \
    -d '{"domain_name": "'$sitename'.sites.stanford.edu" }' \
    -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

    # Clear site caches.
    curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$siteid/cache-clear" \
    -X POST -H 'Content-Type: application/json' \
    -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

    if test $additionalowner = Y; then
      drush @acsf.cardinald7.$sitename ssp-au $additionalownersunetid --name="$additionalownerfullname"
    fi
  # Not really ready.
  else
    echo "Aborting. Run away!"
  fi
# Not ready.
else
  echo "Aborting. Run away!"
fi
printf "\n"
echo "Site setup complete. Go to https://$sitename.sites.stanford.edu to verify setup."
printf "\n"
