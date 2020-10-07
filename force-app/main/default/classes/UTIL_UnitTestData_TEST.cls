/*
    Copyright (c) 2011, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this List of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this List of conditions and the following disclaimer in the
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
*/
/**
* @author Salesforce.org
* @date 2011 (1.x)
* @group Utilities
* @description Contains methods to create test data in various configurations as well to to retrieve specific settings,
*/

@isTest
public class UTIL_UnitTestData_TEST {

    /** @description A mock Account Id .*/
    public static final String MOCK_ACCOUNT_ID = Account.SObjectType.getDescribe().getKeyPrefix() + '000000000001AAA';

    public static final String PROFILE_STANDARD_USER = UTIL_Profile.PROFILE_STANDARD_USER;
    public static final String PROFILE_READONLY_USER = UTIL_Profile.PROFILE_READ_ONLY;

    /**
     * @description Creates a defined number of Test Account records of the specified "Type"
     * @param n Number of Accounts to create
     * @param strType CAO_Constants.BUCKET_ORGANIZATION_TYPE, ONE_TO_ONE_ORGANIZATION_TYPE
     * @return List<Account>
     */
    public static List<Account> createMultipleTestAccounts (Integer n, String strType) {

        List<Account> accountsToAdd = new List<Account> ();

        for (Integer i=0; i<n; i++) {
            Account newAcct = new Account (
                Name = 'Test Account ' + getUniqueString()
            );
            accountsToAdd.add (newAcct);
        }

        return accountsToAdd;
    }

    // =====================================================================================================
    // Methods to Create Test Users
    // =====================================================================================================

    /**
     * @description Create a new user for unit testing.
     * @param strUsername The username for the user to be created
     * @return User
     */
    public static User createNewUserForTests(String strUsername) {
        User u;

        // to work around mixed DML errors during tests, you must
        // create user roles and accounts in their own transactions.
        // got this hack from the web.
        System.runAs(getCurrentUserForRunAs()) {
            u = buildUser('Smith', PROFILE_STANDARD_USER);
            u.Username = strUsername;

            insert u;
        }
        return u;
    }

    /**
     * @description Create a new inactive user for unit testing.  This user will have IsActive set to false.
     * @param strUsername The username for the user to be created
     * @return User
     */
    public static User createNewInactiveUserForTests(String strUsername) {
        User u = createNewUserForTests(strUsername);

        System.runAs(UTIL_UnitTestData_TEST.getCurrentUserForRunAs())  {
            u.IsActive = false;
            update u;
        }

        return u;
    }

    /**
     * @description Create a User having Standard User profile assigned
     * @return User
     */
    public static User createStandardProfileUser() {
        return createUser(PROFILE_STANDARD_USER);
    }

    /**
     * @description Create a User having specified profile assigned
     * @param profileName Profile Name
     * @return Inserted User
     */
    public static User createUser(String profileName) {
        User u = createUserWithoutInsert(profileName);

        //create the user
        System.runAs(u) {}

        return u;
    }

    /**
     * @description Build a User having specified profile assigned, but do not insert
     * @param profileName Profile Name
     * @return User
     */
    public static User createUserWithoutInsert(String profileName) {
        return buildUser(buildUniqueLastName(), profileName);
    }

    /**
     * @description Build a non-English User having specified profile, but do not insert
     * @param profileName Profile Name
     * @return User
     */
    public static User createNonEnglishUserWithoutInsert(String profileName) {
        return buildUser(buildUniqueLastName(), profileName, 'es');
    }

    /**
      * @description Generate a unique string to append to indexed fields to make them unique
      * @return A unique string that uses the crypto class to generate a unique long value
      */
    public static String getUniqueString() {
        return String.valueOf(Math.abs(getRandomLong));
    }

    /**
     * @description Rather than call the Crypto class multiple times, call it only once and then
     * increment the random long value to keep it unique without incurring the extra CPU cycles.
     */
    private static Long getRandomLong {
        get {
            if (getRandomLong == null) {
                getRandomLong = Crypto.getRandomLong();
            } else {
                getRandomLong += 1;
            }
            return getRandomLong;
        } set;
    }

    /**
     * @description Construct a unique last name to be assigned to a User
     * @return String
     */
    private static String buildUniqueLastName() {
        return UserInfo.getOrganizationId() +
            String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') +
            Integer.valueOf(Math.rint(Math.random()*2000000));
    }

    /**
     * @description Build a new User using the Locale and Language settings from the Current User
     * @param lastName Last Name
     * @param profileName Profile Name
     * @return User
     */
    private static User buildUser(String lastName, String profileName) {
        return buildUser(lastName, profileName, UserInfo.getLocale());
    }

    /**
     * @description Build a new User using the specified Locale.
     * @param lastName Last Name
     * @param profileName Profile Name
     * @param localSidKey An NPSP supported locale key (EN_us, es, de, fr, or NL_nl)
     * @return User
     */
    private static User buildUser(String lastName, String profileName, String localSidKey) {
        Profile p = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];

        String alias = lastName.replaceAll(' ', '').leftPad(8, '0').right(8);
        String email = lastName.left(70) + '@email.npsp';

        return new User(
            LastName = lastName,
            Email = email,
            ProfileId = p.Id,
            Username = email,
            Alias = alias,
            TimeZoneSidKey = UserInfo.getTimeZone().toString(),
            LocaleSidKey = (localSidKey != null ? localSidKey : UserInfo.getLocale()),
            LanguageLocaleKey = UserInfo.getLanguage(),
            EmailEncodingKey = 'ISO-8859-1'
        );
    }

    /**
     * @description Retrieve the current User record
     */
    public static User getCurrentUserForRunAs() {
        return new User(Id = UserInfo.getUserId());
    }

    /***
    * @description Ensures that mockIds() does not produce the same ID twice
    */
    private static Integer dummyIdCounter {
        get {
            if (dummyIdCounter == null) {
                dummyIdCounter = 0;
            }
            dummyIdCounter++;
            return dummyIdCounter;
        }
        set;
    }

    /***
    * @description Generates a mock Id for an sObject
    */
    public static Id mockId(SObjectType sObjectType) {
        return mockIds(sObjectType, 1)[0];
    }

    /***
    * @description Generates mock Ids for an sObject
    */
    public static List<Id> mockIds(SObjectType sObjectType, Integer size) {
        String keyPrefix = sObjectType.getDescribe().getKeyPrefix();
        List<Id> ids = new List<Id>();

        for (Integer i = 0; i < size; i++) {
            Integer uniqueCounter = dummyIdCounter;
            ids.add(keyPrefix + '0'.repeat(12 - String.valueOf(uniqueCounter).length()) + uniqueCounter);
        }

        return ids;
    }

    /***
    * @description Sets mock Ids for a list of sObjects
    */
    public static void setMockIds(List<SObject> records) {
        for (SObject record : records) {
            record.Id = mockId(record.getSObjectType());
        }
    }

    /**
     * @description Assert a Visualforce page has an error message displayed
     * @param expectedMsg Expected error message
     * @return void
     */
    public static void assertPageHasError(String expectedMsg) {
        assertPageHasMessage(expectedMsg, ApexPages.Severity.ERROR);
    }

    /**
     * @description Assert a Visualforce page has a message displayed
     * @param expectedMsg Expected error message
     * @param expectedSeverity Expected severity level
     * @return void
     */
    public static void assertPageHasMessage(String expectedMsg, ApexPages.Severity expectedSeverity) {
        ApexPages.Message[] msgs = ApexPages.getMessages();

        System.assert(
            ApexPages.hasMessages(expectedSeverity),
            'Expected page to contain at least one error message. Messages: ' + msgs
        );

        for (ApexPages.Message msg : msgs) {
            if (msg.getSummary().contains(expectedMsg) && msg.getSeverity() == expectedSeverity) {
                return;
            }
        }

        System.assert(false,
            String.format(
                'Cannot find "{0}" in the page messages: ' + msgs,
                new String[] { expectedMsg }
            )
        );
    }

    // =====================================================================================================
    // Test Methods for this Class
    // =====================================================================================================

    /**
     * @description Verify that a new User is inserted with the specified Username
     */
    @IsTest
    private static void shouldCreateNewUser() {
        String randomUsername = 'test@test.com.' + getUniqueString();

        User returnedUser = createNewUserForTests(randomUsername);
        User queriedUser = [
            SELECT
                Username
            FROM User
            WHERE Id = :returnedUser.Id
        ];

        System.assert(randomUsername.equalsIgnoreCase(queriedUser.Username));
    }

    /**
     * @description Verify that a new Inactive User is inserted with the specified Username
     */
    @IsTest
    private static void shouldCreateNewInactiveUserForTests() {
        String randomUsername = 'test@test.com.' + getUniqueString();

        User returnedUser = createNewInactiveUserForTests(randomUsername);

        User queriedUser = [
            SELECT IsActive
            FROM User
            WHERE Id = :returnedUser.Id
        ];

        System.assertEquals(false, returnedUser.IsActive);
        System.assertEquals(false, queriedUser.IsActive);
    }
}