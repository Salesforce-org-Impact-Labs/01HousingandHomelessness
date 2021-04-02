*** Settings ***
Resource        cumulusci/robotframework/Salesforce.robot

*** Variables ***
&{refrec_lex_locators}
...  save=//button[contains(@class, 'slds-button') and @type='button' and text()='Save']