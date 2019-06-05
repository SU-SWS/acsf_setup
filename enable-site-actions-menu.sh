#!/bin/bash
sitename=$1
if [ -z $sitename ]; then
  read -p "Enter the site shortname on ACSF (e.g., \"jumpstartprivacyoffice\", no quotes): " sitename
fi
drush @acsf.cardinald7.$sitename -y dis stanford_jumpstart_shortcuts
drush @acsf.cardinald7.$sitename -y pm-uninstall stanford_jumpstart_site_actions
drush @acsf.cardinald7.$sitename -y en stanford_jumpstart_shortcuts stanford_jumpstart_site_actions
drush @acsf.cardinald7.$sitename scr ready-launch.php
drush @acsf.cardinald7.$sitename role-add-perm --cache-clear=0 "editor" 'access jumpstart help','jumpstart use full block','stanford jumpstart clear caches','stanford jumpstart admin shortcuts'
drush @acsf.cardinald7.$sitename role-add-perm --cache-clear=0 "site owner" 'administer stanford homepage','see enabled homepage options','access jumpstart help','access jumpstart features','jumpstart use full block','stanford jumpstart clear caches','stanford jumpstart admin shortcuts'
drush @acsf.cardinald7.$sitename role-add-perm --cache-clear=0 "administrator" 'administer stanford homepage','see enabled homepage options','administer jumpstart help','access jumpstart help','access jumpstart features','jumpstart use full block','stanford jumpstart clear caches','stanford jumpstart admin shortcuts','stanford jumpstart 404 report','stanford jumpstart 403 report','stanford jumpstart dblog report','stanford jumpstart search report','configure jumpstart responsive tables'
drush @acsf.cardinald7.$sitename cc all
