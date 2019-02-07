#!/bin/bash
sitename=$1
if [ -z $sitename ]; then
  read -p "Enter the site shortname on ACSF (e.g., \"sara\", no quotes): " sitename
fi
drush @acsf.cardinald7.$sitename php-eval 'variable_set("context_status", array("vpsa_homepage_dickinson" => TRUE))'
drush @acsf.cardinald7.$sitename cc all
