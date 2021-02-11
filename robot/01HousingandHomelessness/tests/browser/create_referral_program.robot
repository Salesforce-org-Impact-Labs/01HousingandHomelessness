*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects

Suite Setup     Open Test Browser
# Suite Teardown  Delete Records and Close Browser


*** Variables ***

${Save_Button}  //button[contains(@class, 'slds-button') and @type='button' and contains(text(), 'Save')]

*** Test Cases ***

Create Referral Program

    Go To Page                              Listing
    ...                                     Service__c
    Click Object Button                     New

    Populate Field                          Name                My First Program
    Populate Field                          Phone               555-555-1234
    Populate Field                          Website             www.google.com
    Populate Field                          Description         My program description
    Populate Field                          Minimum Age         17
    Populate Field                          Maximum Age         30
    Populate Field                          Street              355 15th Street
    Populate Field                          City                San Francisco
    Populate Field                          Zip Code            95202
    Populate Field                          Latitude            37.7897
    Populate Field                          Longitude            -122.397

    Click Button                            ${Save_Button}