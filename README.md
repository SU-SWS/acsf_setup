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

## Launch Tasks
1. Run `./jumpstart-launch-tasks.sh`

## NetDB Setup
This script will create a node in NetDB for a custom hostname (vhost) on ACSF.
1. Run `./netdb.sh`

## Setting Up the Custom Domain on ACSF
This script will add the hostname created with `netdb.sh` to ACSF. 
You **must** wait until after the DNS push due to a bug (https://stanfordits.atlassian.net/browse/SITES-911)
1. Run `./custom-domain.sh`


## Notes and Caveats
1. You must have drush aliases for ACSF set up.
2. You must have drush in your `$PATH`. Run `which drush` and it should return the location of drush.
