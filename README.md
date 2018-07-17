# ACSF Setup
This is a script to perform the manual tasks that SWS team members must to to finalize setup of a new group/department site on Stanford Sites 2.0 (ACSF). We hope that this does not have a very long lifespan.

## Initial configuration
1. Log into the ACSF dashboard and [go to your user account](https://www.cardinalsites.acsitefactory.com/user). Click the "API key" tab to get your API key.
2. If a `~/.bash_env` file does not exist, create one.
3. Add the following lines to your `~/.bash_env` file:
```
export ACSF_USERNAME="<Your ACSF Username>"
export ACSF_API_KEY="<yourapikey>"
```
4. Run `source ~/.bash_env`. (You only need to do this the first time.)
5. Run `cd acsf_setup`.
6. Run `./acsf_setup.sh` and follow the prompts.