# 01HousingandHomelessness

Impact Lab - Housing & Homelessness

![Manual Production Package Release](https://github.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/workflows/Manual%20Production%20Package%20Release/badge.svg)
![Beta Package and Install](https://github.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/workflows/Package%20and%20Install/badge.svg)

## Installation and setup

install package using the link from Releases above

Complete the following required setup steps

1. [Permissions Setup](/docs/permissions-setup.md)
2. [Data Setup](/docs/data-setup.md)
3. [Messaging Setup](/docs/messaging-setup.md)

### Optional steps

1. [Adjust scoring metrics](/docs/scoring-metrics.md)
2. [UI Setup](/docs/ui-setup.md)
3. [Client Profile Builder Flow](/docs/client-profile.md)

## Development

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. You can now use sfdx commands like `org:open`, push, pull, etc.
4. After step 2, you can run `cci task run run_tests --org dev` to run all the apex tests
5. Delete orgs like this `cci org scratch_delete dev`

## Sample Data

1. Put data in the org however you like
2. Run `cci task run extract_dataset`

## Packaging

1. The packaging flow creates a new beta package when you merge your PR into master
2. It's possible that you'll get a passing PR check (it deploys, all tests pass) but then there are packaging errors (namespace issues, overall code coverage < 75%, etc)
3. `cci flow run release_production --org packaging` will do a non-beta release

## Troubleshooting

If the default org doesn't show up down in the vscode tray, you can run `cci org default dev` to manually set the default org
