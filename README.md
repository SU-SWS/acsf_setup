# ACSF Setup
This is a script to perform the manual tasks that SWS team members must use to finalize setup of a new group/department site on Stanford Sites 2.0 (ACSF). We hope that this does not have a very long lifespan.

**Version 0.x**

## Initial configuration
1. Log into the ACSF dashboard and [go to your user account](https://www.cardinalsites.acsitefactory.com/user). Click the "API key" tab to get your API key.
2. If a `~/.bash_profile` file does not exist, create one.
3. Add the following lines to your `~/.bash_profile` file:
```
export ACSF_USERNAME="<Your ACSF Username>"
export ACSF_API_KEY="<yourapikey>"
```
4. Run `source ~/.bash_profile`. (You only need to do this the first time.)

# Use

## Group and Department Site Setup on ACSF ("cardinald7" stack)
1. Run `cd acsf-setup`.
2. Run `./acsf-setup.sh` and follow the prompts.

## Personal Setup on ACSF ("leland" stack)
1. Run `./acsf-people-setup.sh` and follow the prompts.

## Jumpstart Site Setup
1. Run `./jumpstart-setup.sh` and follow the prompts.

### Tips on Jumpstart Site Setup prompts

1. The **requester** will be assigned the administrator role.
Since the administrator role is not recommended for typical Jumpstart Site Owners, you'll probably want to use your own SUNetID and name.

2. Here are some product names:
* stanford_sites_jumpstart
* stanford_sites_jumpstart_plus
* stanford_sites_jumpstart_academic
* stanford_sites_jumpstart_lab
* stanford_sites_jumpstart_vpsa
* stanford_sites_jumpstart_engineering


### Example of running jumpstart-setup.sh:
```
$ ./jumpstart-setup.sh
Enter the "Website address" from the SNOW request (e.g., "appliedmetaphysics"; no quotes): udl
Enter the "Website Title" from the SNOW request (e.g., "Department of Applied Metaphysics"; no quotes): Universal Design for Learning
Enter the requester's SUNetID (e.g., "ahislop"; no quotes): izaks
Enter the requester's Full Name from the SNOW request (e.g., "Alyssa Hislop"; no quotes): Irina Zaks
Enter the machine name of the product you would like to install (e.g., "stanford_sites_jumpstart", "stanford_sites_jumpstart_plus", "stanford_sites_jumpstart_academic", "stanford_sites_jumpstart_lab"; no quotes): stanford_sites_jumpstart_vpsa
Did the requester specify an additional owner? (Y/N; case-sensitive): N


########################
The site's short name is: udl
The site's title is: Universal Design for Learning
The requester's SUNetID is: izaks
The requester's Full Name is: Irina Zaks
The product is: stanford_sites_jumpstart_vpsa
There are no additional owners.
########################


Are you ready to proceed? (Y/N): Y
There is no undo. Are you sure you are ready to proceed? (Y/N): Y
You are about to DROP all tables in your 'cardinalddb482729' database. Do you want to continue? (y/n): y
```

## Launch Tasks
1. Run `./jumpstart-launch-tasks.sh`

## Setting Up the Custom Domain on ACSF
This script will add the hostname created with `netdb.sh` to ACSF.
Run this prior to running the netdb script as adding the entry to netdb is "going live". You can do this far in advance of netdb.
1. Run `./custom-domain.sh`

## NetDB Setup
This script will create a node in NetDB for a custom hostname (vhost) on ACSF.
1. Run `./netdb.sh`

## Submitting a Sitemap to Google
This script will:
1. Enable `xmlsitemap`, `xmlsitemap_engines`, and `xmlsitemap_menu`
2. Add the links from the Main Menu to the XML sitemap
3. Submit the XML sitemap to Google for indexing

Use:
1. Run `./google.sh`

## Clearing Varnish Cache
1. Run `./clear-varnish-cache-api.sh`

**Note**: This will clear Drupal caches and Varnish caches for the _entire site_.

## Notes and Caveats
1. You must have drush aliases for ACSF set up.
2. You must have drush in your `$PATH`. Run `which drush` and it should return the location of drush.
