/*
    Copyright (c) 2014 Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
/**
* @author Salesforce.org
* @date 2014
* @group Utilities
* @description This class allows easy access to object and field description information from within other classes.
*
* It is called statically, and therefore will supply the same information to all calls made from
* within one transaction, or set of trigger calls. This is beneficial because this info should
* be the same for all calls in a transaction, and by calling it statically we reduce the calls
* that are made, making the total transaction more efficient.
*/
@isTest
private with sharing class UTIL_Describe_TEST {

    @IsTest
    private static void shouldReturnExpectedDescribes() {
        String s;

        Schema.DescribeSObjectResult res = UTIL_Describe.getObjectDescribe('Contact');
        System.assertEquals(res.getName(), 'Contact');
        s = UTIL_Describe.getObjectLabel('Contact');
        System.assertEquals (s, res.getLabel());


        s = UTIL_Describe.getFieldLabel('Account', 'LastModifiedDate');

        Schema.DescribeFieldResult fr = UTIL_Describe.getFieldDescribe('Account', 'CreatedDate');
        s = UTIL_Describe.getFieldLabel('Account', 'CreatedDate');
        System.assertEquals (s, fr.getLabel());

        Map<String, Schema.DescribeFieldResult> afd = UTIL_Describe.getAllFieldsDescribe('Account');
        System.assertEquals ('BillingCity', afd.get('billingcity').getName());
        afd = UTIL_Describe.getAllFieldsDescribe('Account');

        SObject acctObj = UTIL_Describe.getPrototypeObject('Account');
        // should be able to cast to Account
        Account acct = (Account)(acctObj);

        s = UTIL_Describe.getFieldType('Account', 'CreatedDate');
        System.assertEquals('DATETIME', s);

        s = UTIL_Describe.getNameField('Account');
        System.assertEquals('name', s);

        try {
            s = UTIL_Describe.getObjectLabel('sdlkfjsdlkfjsldkfjlsdkfj');
        } catch (Exception e) {
            System.assertEquals('Invalid object name \'sdlkfjsdlkfjsldkfjlsdkfj\'', e.getMessage());
        }
        try {
            s = UTIL_Describe.getFieldLabel('Opportunity', 'sdlkfjsdlkfjsldkfjlsdkfj');
        } catch (Exception e) {
            System.assertEquals('Invalid field name \'sdlkfjsdlkfjsldkfjlsdkfj\'', e.getMessage());
        }
    }
    /**
    * @description Validate that active picklist options are identified.
    */
    @IsTest
    private static void shouldIdentifyValidPicklistOptions() {
        final String objectName = 'Opportunity';
        final String fieldName = 'StageName';
        final String bogusValue = 'slfdkjlsdfj';

        Schema.DescribeFieldResult describeField =
            UTIL_Describe.getFieldDescribe('Opportunity', 'StageName');
        String picklistValue;
        for (Schema.PicklistEntry entry : describeField.getPicklistValues()) {
            if (entry.isActive()) {
                picklistValue = entry.getValue();
                break;
            }
        }

        System.assertEquals(true,
            UTIL_Describe.isValidPicklistOption(objectName, fieldName, picklistValue),
            'isValidPicklistOption() should return true for an active picklist value');
        System.assertEquals(false,
            UTIL_Describe.isValidPicklistOption(objectName, fieldName, bogusValue),
            'isValidPicklistOption() should return false for a picklist value that does not exist');
    }
}