*** Settings ***
Resource        robot/01HousingandHomelessness/resources/Refrec.robot
Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects

Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser


*** Variables ***

${Save_Button}  //button[contains(@class, 'slds-button') and @type='button' and text()='Save']
# ${Save_Button}  refrec:modal_button.save

*** Keywords ***

Navigate to Referral Program Tab
    Go To Page                              Listing             Service__c

Click Referral Program "New" Button
    Click Object Button                     New
    Wait For Modal                          New                 Service__c

Populate New Referral Program Modal with Fake Data

    Populate Form                           Name=My Referral Program
    ...                                     Phone=${faker.phone_number()}
    ...                                     Website=${faker.url()}
    ...                                     Description=${faker.paragraph(nb_sentences=3)}
    ...                                     Minimum Age=${faker.random_int(min=0, max=20)}
    ...                                     Maximum Age=${faker.random_int(min=20, max=150)}
    ...                                     Street=${faker.street_address()}
    ...                                     City=${faker.city()}
    ...                                     Zip Code=${faker.postcode()}
    ...                                     Latitude=${faker.random_int(min=-90, max=90)}.${faker.random_int(min=0, max=999999)}
    ...                                     Longitude=${faker.random_int(min=-180, max=180)}.${faker.random_int(min=0, max=999999)}

Click Save Button
    Click Button                            ${Save_Button}

Click on Newly Created Referral Program
    Click Link                              My Referral Program


*** Test Cases ***

Create Referral Program
    [Documentation]     Create a Referral Program, populate it with fake date, and save it.

    Navigate to Referral Program Tab
    Click Referral Program "New" Button
    Populate New Referral Program Modal with Fake Data
    Click Save Button
    Wait Until Modal Is Closed
    Navigate to Referral Program Tab
    Click on Newly Created Referral Program