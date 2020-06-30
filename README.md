# 01HousingandHomelessness

Impact Lab - Housing & Homelessness

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

## Troubleshooting

If the default org doesn't show up down in the vscode tray, you can run `cci org default dev` to manually set the default org
