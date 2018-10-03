#!/bin/bash
printf "\n"
echo "This script is for setting up personal websites on people.stanford.edu"
printf "\n"
read -p "Enter the requester's SUNetID (e.g., \"ahislop\"; no quotes): " sunetid
read -p "Enter the requester's Full Name from the SNOW request (e.g., \"Alyssa Hislop\"; no quotes): " fullname
# read -p "Enter the numeric site_id that was returned from the Acquia API in the RIT (e.g., \"1081\"; no quotes): " siteid

# Confirmation
printf "\n"
printf "\n"
echo "########################"
echo "The requester's SUNetID is: "$sunetid
echo "The requester's Full Name is: "$fullname
echo "########################"
printf "\n"
printf "\n"
read -p "Are you ready to proceed? (Y/N): " ready
if test $ready = Y; then
  read -p "There is no undo. Are you sure you are ready to proceed? (Y/N): " reallyready
  if test $reallyready = Y; then

    # Add the requester as an administrator.
    drush @acsf.leland.$sunetid ssp-au $sunetid --name="$fullname" --roles="administrator"
    # Set site title.
    drush @acsf.leland.$sunetid -y vset site_name "$fullname"
    # Set site email to user's email address.
    drush @acsf.leland.$sunetid -y vset site_mail "$sunetid@stanford.edu"
    # Clear caches.
    drush @acsf.leland.$sunetid cc all

    printf "\n"
    echo "Site setup complete. Go to https://$sunetid.people.stanford.edu to verify setup."
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
