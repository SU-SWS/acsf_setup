#!/bin/bash
read -p "Enter the site shortname on ACSF (e.g., \"jumpstartlockss\", no quotes): " sitename
# Baby, what time is it?
timestamp=$(date +%Y%m%d%H%M%S)
howardpass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
lindseypass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
richardpass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
adminpass="cat /dev/urandom | tr -cd a-zA-Z0-9_+=*\ | fold -w18 | head -n 1"
drush @acsf.cardinald7.$sitename -y en googleanalytics site_verify xmlsitemap xmlsitemap_menu xmlsitemap_engines
drush @acsf.cardinald7.$sitename -y vset --always-set block_cache 1
drush @acsf.cardinald7.$sitename -y vset --always-set cache 1
# cache_lifetime, page_cache_maximum_age, and page_compression are all hard-coded in factory hooks.
# drush @acsf.cardinald7.$sitename -y vset --always-set cache_lifetime 0
# drush @acsf.cardinald7.$sitename -y vset --always-set page_cache_maximum_age 21600
# drush @acsf.cardinald7.$sitename -y vset --always-set page_compression 0
drush @acsf.cardinald7.$sitename -y vset --always-set features_rebuild_on_flush FALSE
drush @acsf.cardinald7.$sitename -y vset --always-set preprocess_css 1
drush @acsf.cardinald7.$sitename -y vset --always-set preprocess_js 1
drush @acsf.cardinald7.$sitename -y vset --always-set redirect_auto_redirect 1
drush @acsf.cardinald7.$sitename -y dis stanford_metatag_nobots nobots
drush @acsf.cardinald7.$sitename upwd Howard --password="$howardpass"
drush @acsf.cardinald7.$sitename upwd Lindsey --password="$lindseypass"
if [ -n "`drush @acsf.cardinald7.$sitename sqlq 'SELECT * FROM users where name = "Richard"'`" ]; then
  drush @acsf.cardinald7.$sitename upwd Richard --password="$richardpass"
fi
drush @acsf.cardinald7.$sitename upwd admin --password="$adminpass"
drush @acsf.cardinald7.$sitename sqlq 'insert into site_verify values ("99","google","","This is a verification page.","<meta name=\"google-site-verification\" content=\"tUJ214wF9k79KCsAn5wIOyOFR2eH0RlBANimm5MCFfU\" />")'
drush @acsf.cardinald7.$sitename cc menu
drush @acsf.cardinald7.$sitename scr ready-launch.php
php -r "print json_encode(array('status' => '1', 'priority' => '0.6'));" | drush @acsf.cardinald7.$sitename vset --format=json xmlsitemap_settings_menu_link_main-menu -
drush @acsf.cardinald7.$sitename cc all
drush @acsf.cardinald7.$sitename apd8f
