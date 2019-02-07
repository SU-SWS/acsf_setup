#!/bin/bash
sitename=$1
if [ -z $sitename ]; then
  read -p "Enter the site shortname on ACSF (e.g., \"langcenterasl\", no quotes): " sitename
fi
drush @acsf.cardinald7.$sitename php-eval 'variable_set("context_status", array("9-col-banner-fsb-homepage" => FALSE))'
drush @acsf.cardinald7.$sitename cc all
