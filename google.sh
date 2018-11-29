#!/bin/bash

read -p "Enter sitename (e.g., \"mindovermoney\", no quotes): " sitename
drush @acsf.cardinald7.$sitename -y en xmlsitemap_engines xmlsitemap_menu

php -r "print json_encode(array('status' => '1', 'priority' => '0.6'));" | drush @acsf.cardinald7.$sitename vset --format=json xmlsitemap_settings_menu_link_main-menu -

php -r "print json_encode(array('google'));" | drush @acsf.cardinald7.$sitename -y vset --format=json xmlsitemap_engines_engines -

drush @acsf.cardinald7.$sitename cron
