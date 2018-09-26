#!/bin/bash

# Prerequisite:
# 1. SSH Access to ACSF environment configured.
# 2. Drush aliases set up (Drush <=8) https://github.com/SU-SWS/acsf-cardinald7/blob/1.x/drush/site-aliases/acsf.aliases.drushrc.php
# We don't have aliases configured for Drush 9 yet.

# Default stack.
stack='cardinald7'

# Get the machine name for the site on ACSF.
read -p "What is the site shortname on ACSF (e.g., \"jumpstartlockss\", no quotes)" sitename

# Get the stack that it is on.
 echo "Which stack is the site on?"
  select stackchoice in "Sites (cardinald7)" "People (leland)"; do
  case $stackchoice in
    'Sites (cardinald7)' )
      stack='cardinald7'
      break;;
    'People' )
      stack='leland'
      exit;;
  esac
done

# Build the drush alias.
drushalias="@acsf.$stack.$sitename"

# Baby, what time is it?
timestamp=$(date +%Y%m%d%H%M%S)
howardpass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
lindseypass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
adminpass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
drush $drushalias -y en googleanalytics site_verify xmlsitemap xmlsitemap_menu xmlsitemap_engines
drush $drushalias -y vset --always-set block_cache 1
drush $drushalias -y vset --always-set cache 1
drush $drushalias -y vset --always-set cache_lifetime 0
drush $drushalias -y vset --always-set features_rebuild_on_flush FALSE
drush $drushalias -y vset --always-set page_cache_maximum_age 21600
drush $drushalias -y vset --always-set preprocess_css 1
drush $drushalias -y vset --always-set preprocess_js 1
drush $drushalias -y vset --always-set page_compression 0
drush $drushalias -y vset --always-set redirect_auto_redirect 1
drush $drushalias -y dis stanford_metatag_nobots nobots 
drush $drushalias upwd Howard --password="$howardpass"
drush $drushalias upwd Lindsey --password="$lindseypass"
drush $drushalias upwd admin --password="$adminpass"
drush $drushalias sqlq 'insert into site_verify values ("99","google","","This is a verification page.","<meta name=\"google-site-verification\" content=\"tUJ214wF9k79KCsAn5wIOyOFR2eH0RlBANimm5MCFfU\" />")'
drush $drushalias cc menu
drush $drushalias scr ready-launch.php
php -r "print json_encode(array('status' => '1', 'priority' => '0.6'));" | drush $drushalias vset --format=json xmlsitemap_settings_menu_link_main-menu -
drush $drushalias cc all
