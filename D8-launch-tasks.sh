#!/bin/bash
read -p "Enter the site shortname on ACSF (e.g., \"virtualvisit\", no quotes): " sitename
# Baby, what time is it?
timestamp=$(date +%Y%m%d%H%M%S)
# Generate a random 18-character password that can include mixed-case,
# alphanumeric, and "_-!.+".
jamiepass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
kennedypass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
morganpass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
sampass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
alexpass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
adminpass=$(cat /dev/urandom | LC_ALL=C tr -cd a-zA-Z0-9\_\-\!\.\+ | fold -w18 | head -n 1)
drush @$sitename.01live upwd Jamie "$jamiepass"
drush @$sitename.01live upwd Kennedy "$kennedypass"
drush @$sitename.01live upwd Morgan "$morganpass"
drush @$sitename.01live upwd Alex "$alexpass"
drush @$sitename.01live upwd Sam "$sampass"
drush @$sitename.01live upwd sws-developers "$adminpass"
drush @$sitename.01live cr
