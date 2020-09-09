# Messaging Setup


# Configuring an Email Service for the Client Recommendations Inbound Email Handler

This may feel like lot to do and it may force you to visit screens with which you aren’t usually familiar, but take heart - this is a one-time task that should take you only about 15 minutes.

## Create the Email Service

Search setup for “Email Services”, then create a New Email Service
<img alt="New Email Services" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/f2b468ebdbab7af8014edfb96ab8c299f129a42e/docs/images/New_Email_Service.png">

* The Service Name can be anything meaningful. Here, we’ve used “Client Referral Email Service”
* The Apex Class must be **RecommendationsInboundEmailHandler**
* Be sure to check the box to make the service Active!

### Create a new Email Address

<img alt="New Email Address" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/e26879b1ed4e5eac1ea75f8a7470171f25b3c998/docs/images/New_Email_Address.png">


* Email Address Name and Email Address: We’ve kept the email name and address consistent with the name of the email service, but that isn’t necessary. You can give it any name that is meaningful to you.
* Be sure to Activate the address
* Context User: Choose a user that has System Administrator privileges. This user will be the owner of any record created by the inbound email handler.
    * We suggest that you create a special User for this purpose, one that would never become Inactive.
* Accept Email from: delete the pre-populated value from this field
* Be sure to copy that email address onto your clipboard, you’ll need it again in a moment

## Create the Org Wide Email Address

After the Email Address is created, we need to make it an Org-Wide Email so that we can use this email address as the “Reply-To” email in our messages to the Client.
<img alt="Complete Email Service" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/549b88e7011090585790152d3efcf8c5b7296899/docs/images/Complete_Email_Service.png">
Get the email address, create an org-wide email for that address. **Hint**: name it something to match your organization!

Search Setup for “Organization-Wide Addresses”

<img alt="Org Wide Email" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/0afb930a541025b8ed67dec8d827c510a355034c/docs/images/Create_Org_Wide_Email.png">

1. Choose a meaningful Display Name - perhaps the name of your organization - this will appear as the Sender for messages that are sent by the system.
2. Copy the Email Address created above, when you were setting up the Email Service - it will be a very long email address.
3. Choose the profiles that may use this address - be sure you include the Profile of the Context User.

## Confirm the Organization-Wide Email Address

In order for the Organization-Wide email be be activated, that email address must first be validated.

<img alt="Validate Email Address" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/3038a4fad16030a64ade1afff849dbd93c0f26c8/docs/images/Validate_Email_Address.png">

Because the “recipient” of this org-wide email is the system itself, we’ve tried to make it easy for you to validate the address.

When the Email Service handler code receives a request to validate the email address, it will create a Task. This Task will be assigned to the Context User that you’ve specified above, when you created the Email Address.


1. Log in as the Context User and navigate to the Home tab, where you can view the Tasks that have been assigned to this user.
2. For Lightning users, ensure your Task List is set to show "My Tasks"
<img alt="Task View" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/b736c43294d4bded9cb69dd4f347da3f04506a09/docs/images/Confirm_Address_Task.png">
3. Open the special Task by clicking on the Subject, “Confirm Organization-Wide Email Address”

<img alt="My Tasks" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/29e4326b8c7a0af7460c32b12c69065b1161b7e6/docs/images/My_Tasks.png">

1. The Comments of the task will contain the text of the verification email. In the text will be a link to confirm the Organization-Wide Email Address. Click the link or copy and paste it into a browser to confirm the address.

<img alt="Confirm Address Task" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/37a1434f10e3ace13d2b82e7e4c328f6d5c22ae4/docs/images/Confirm_Address_Task.png">

When the link is clicked or entered into a browser, you should see a success message

<img alt="Success Message" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/48bb79badf73359649ef86a1101fe5bd176e50d2/docs/images/Confirm_Message.png">

## Configure the Email in the Custom Metadata Type Record

Use the Quick Find capability in setup to search for “Custom Metadata Types”. Once you’re on the “All Custom Metadata Types” page, click the “Manage Records” link for the Referral Recommendations Setting custom metadata type. 

<img alt="Custom Metadata Type" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/282de7c81db1fde98e14fda74481067db3501d7f/docs/images/Custom_Metadata_Type.png">

Edit the Organization Default record, then enter the email service’s email address into the “Recommendations Email Service Address” field.

<img alt="Referral Recommendations Setting" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/282de7c81db1fde98e14fda74481067db3501d7f/docs/images/Referral_Recommendations_Setting.png">

# Schedule the Batch Jobs

There are two batch jobs that need to run to send referrals and referral followup messages to clients.

* Batch_SendInitialClientReferrals
* Batch_SendReferralFollowupReminders

These batch classes should execute at least once per day. Please follow the instructions in the Help documentation to schedule the classes: https://help.salesforce.com/articleView?id=code_schedule_batch_apex.htm&type=5

Suggested names for the jobs are:
  * InitialReferral
  * Referral Followup

If you wish, you may also execute the batch jobs outside of a schedule. 

The batch classes may be run at any time by utilizing the Execute Anonymous function in Salesforce. Please review the instructions in the Help documentation for more information: https://help.salesforce.com/articleView?id=code_dev_console_execute_anonymous.htm&type=5

To execute the initial referral batch job, execute the following code snippet:
refrec.Batch_SendInitialClientReferrals batchable = new refrec.Batch_SendInitialClientReferrals();
Database.executeBatch(batchable);

To execute the referral followup batch job, execute the following code snippet:
refrec.Batch_SendReferralFollowupReminders  batchable = new refrec.Batch_SendReferralFollowupReminders();
Database.executeBatch(batchable);
