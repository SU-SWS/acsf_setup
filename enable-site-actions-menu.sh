#!/bin/bash
sitename=$1
if [ -z $sitename ]; then
  read -p "Enter the site shortname on ACSF (e.g., \"jumpstartprivacyoffice\", no quotes): " sitename
fi
drush @acsf.cardinald7.$sitename -y dis stanford_jumpstart_shortcuts
drush @acsf.cardinald7.$sitename -y pm-uninstall stanford_jumpstart_site_actions
drush @acsf.cardinald7.$sitename -y en stanford_jumpstart_shortcuts stanford_jumpstart_site_actions
drush @acsf.cardinald7.$sitename scr ready-launch.php
drush @acsf.cardinald7.$sitename cc all
