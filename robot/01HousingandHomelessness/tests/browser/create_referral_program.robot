*** Settings ***
Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.locator_manager
Resource        robot/01HousingandHomelessness/resources/locators.robot
Library         cumulusci.robotframework.PageObjects

Suite Setup     Run Keywords
...             Register Locators  refrec  ${refrec_lex_locators}
...             AND  Open Test Browser
Suite Teardown  Delete Records And Close Browser


*** Test Cases ***
Create Referral Program
    [Documentation]     Create a Referral Program, populate it with fake date, and save it.

    Navigate To Referral Program Tab
    Click Referral Program "New" Button
    Populate New Referral Program Modal With Fake Data
    Click Save Button
    Wait Until Modal Is Closed
    Navigate To Referral Program Tab
    Click On Newly Created Referral Program


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
    Click Button                            refrec:save

Click on Newly Created Referral Program
    Click Link                              My Referral Program