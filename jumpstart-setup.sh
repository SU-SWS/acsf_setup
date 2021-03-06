#!/bin/bash
read -p "Enter the \"Website address\" from the SNOW request (e.g., \"appliedmetaphysics\"; no quotes): " sitename
read -p "Enter the \"Website Title\" from the SNOW request (e.g., \"Department of Applied Metaphysics\"; no quotes): " sitetitle
read -p "Enter the requester's SUNetID (e.g., \"ahislop\"; no quotes): " sunetid
read -p "Enter the requester's Full Name from the SNOW request (e.g., \"Alyssa Hislop\"; no quotes): " fullname
#read -p "Enter the numeric site_id that was returned from the Acquia API in the RIT (e.g., \"1081\"; no quotes): " siteid
read -p "Enter the machine name of the product you would like to install (e.g., \"stanford_sites_jumpstart\", \"stanford_sites_jumpstart_plus\", \"stanford_sites_jumpstart_academic\", \"stanford_sites_jumpstart_lab\"; no quotes): " product
read -p "Did the requester specify an additional owner? (Y/N; case-sensitive): " additionalowner
if test $additionalowner = Y; then
  read -p "Enter the addtional owner's SUNetID (e.g., \"jbickar\"): " additionalownersunetid
  read -p "Enter the additional owner's Full Name from the SNOW request (e.g., \"John Bickar\"): " additionalownerfullname
fi

# Confirmation
printf "\n"
printf "\n"
echo "########################"
echo "The site's short name is: "$sitename
echo "The site's title is: "$sitetitle
echo "The requester's SUNetID is: "$sunetid
echo "The requester's Full Name is: "$fullname
echo "The product is: "$product
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
    # Install the site.
    drush @acsf.cardinald7.$sitename -y si $product --account-mail="sws-developers@lists.stanford.edu"
    # Disable the update module.
    drush @acsf.cardinald7.$sitename -y dis update
    # Add the requester as an administrator.
    drush @acsf.cardinald7.$sitename ssp-au $sunetid --name="$fullname" --roles="administrator"
    # Set site title.
    drush @acsf.cardinald7.$sitename -y vset site_name "$sitetitle"
    # Set site email to user's email address.
    drush @acsf.cardinald7.$sitename -y vset site_mail "$sunetid@stanford.edu"
    # Add info for additional owner.
    if test $additionalowner = Y; then
      drush @acsf.cardinald7.$sitename ssp-au $additionalownersunetid --name="$additionalownerfullname"
    fi
    # Clear caches.
    drush @acsf.cardinald7.$sitename cc all

    # Add an ACSF API call to create the custom domain. Use environment variables to authenticate against the API.
    # No longer necessary per https://insight.acquia.com/support/tickets/715265
    # curl "https://www.cardinalsites.acsitefactory.com/api/v1/domains/$siteid/add" \
    # -X POST -H 'Content-Type: application/json' \
    # -d '{"domain_name": "'$sitename'.sites.stanford.edu" }' \
    # -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

    # Clear site caches.
    # Commenting this out for now to see if "drush cc all" is sufficient. Digging the site_id out of the
    # RITM is a pain.
    # curl "https://www.cardinalsites.acsitefactory.com/api/v1/sites/$siteid/cache-clear" \
    # -X POST -H 'Content-Type: application/json' \
    # -v -u "$ACSF_USERNAME":"$ACSF_API_KEY"

    printf "\n"
    echo "Site setup complete. Go to https://$sitename.sites.stanford.edu to verify setup."
    printf "\n"
    echo "Wait 3-8 minutes for SAML authentication to work."
    printf "\n"

  # Not really ready.
  else
    echo "Aborting. Run away!"
  fi
# Not ready.
else
  echo "Aborting. Run away!"
fi
