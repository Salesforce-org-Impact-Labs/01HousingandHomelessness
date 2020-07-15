# 01HousingandHomelessness

Impact Lab - Housing & Homelessness

## Installation and setup

install package using <https://login.salesforce.com/packaging/installPackage.apexp?p0=04t3h000004kKwZ>

Complete the following required setup steps

1. [Permissions Setup](/docs/permissions-setup.md)
2. [Data Setup](https://github.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/blob/master/docs/data-setup.md)
3. [UI Setup](https://github.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/blob/master/docs/data-setup.md)
4. [Messaging Setup](https://github.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/blob/master/docs/messaging-setup.md)

### Optional steps

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

1. The packaging flow runs when you merge your PR into master
2. It's possible that you'll get a passing PR check (it deploys, all tests pass) but then there are packaging errors (namespace issues, overall code coverage < 75%, etc)

## Troubleshooting

If the default org doesn't show up down in the vscode tray, you can run `cci org default dev` to manually set the default org
