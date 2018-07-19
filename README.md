# ACSF Setup
This is a script to perform the manual tasks that SWS team members must to to finalize setup of a new group/department site on Stanford Sites 2.0 (ACSF). We hope that this does not have a very long lifespan.

**Version 0.x**

## Initial configuration
1. Log into the ACSF dashboard and [go to your user account](https://www.cardinalsites.acsitefactory.com/user). Click the "API key" tab to get your API key.
2. If a `~/.bash_env` file does not exist, create one.
3. Add the following lines to your `~/.bash_env` file:
```
export ACSF_USERNAME="<Your ACSF Username>"
export ACSF_API_KEY="<yourapikey>"
```
4. Run `source ~/.bash_env`. (You only need to do this the first time.)

# Use
1. Run `cd acsf-setup`.
2. Run `./acsf-setup.sh` and follow the prompts.

## Notes and Caveats
1. You must have drush aliases for ACSF set up.
2. You must have drush in your `$PATH`. Run `which drush` and it should return the location of drush.
