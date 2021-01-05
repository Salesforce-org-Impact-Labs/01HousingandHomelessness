# Messaging Setup


# Configuring an Email Service for the Client Recommendations Inbound Email Handler

Message setup takes about 15 minutes.

## Create the Email Service

From Setup, in the Quick Find box enter Email Services, then in Email Service Name, enter a name of your choice.
<img alt="New Email Services" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/f2b468ebdbab7af8014edfb96ab8c299f129a42e/docs/images/New_Email_Service.png">

* The example shows Client Referral Email Service
* From Apex Class select RecommendationsInboundEmailHandler
* To activate the service, check Active.

### Create a New Email Address

<img alt="New Email Address" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/e26879b1ed4e5eac1ea75f8a7470171f25b3c998/docs/images/New_Email_Address.png">


* In Email Address Name and Email Address enter the name of your choice. You can match the names or enter different names. To Activate the address, check Active
* From Context User,  select a user that has System Administrator privileges. This user will be the owner of any record created by the inbound email handler.
   * Note: Create a special context user so that it doesn’t become inactive.
* From Accept Email From, cut and paste  the pre-populated value to your clipboard to reuse later.

## Create Your Organization-Wide Email Address

After you create the Email Address, make it an Organization-Wide Email so that you can use this email address as the Reply-To email in messages to your clients. Match the name to your organization.
<img alt="Complete Email Service" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/549b88e7011090585790152d3efcf8c5b7296899/docs/images/Complete_Email_Service.png">

1. From Setup, in the Quick Find box, enter  Organization-Wide Addresses, and then enter a Display Name to appear as the Sender for system-sent emails. 


<img alt="Org Wide Email" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/0afb930a541025b8ed67dec8d827c510a355034c/docs/images/Create_Org_Wide_Email.png">

2. Copy the email address that you saved to your clipboard and paste it to Email Address. - It will be a long address.
3. Select the profiles that you want to use this address. Make sure to include the Context User profile.

## Confirm the Organization-Wide Email Address

To activate the Organization-Wide email, first validate the email address.

<img alt="Validate Email Address" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/3038a4fad16030a64ade1afff849dbd93c0f26c8/docs/images/Validate_Email_Address.png">

When the Email Service handler code receives a request to validate the email address, it creates a Task. This Task is assigned to the Context User that you specified when you created the Email Address.

1. Log in as the Context User and navigate to the Home tab, where you can view the Tasks assigned to this user.
2. For Lightning users, ensure that the Task List is set to show My Tasks
<img alt="Task View" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/b736c43294d4bded9cb69dd4f347da3f04506a09/docs/images/Confirm_Address_Task.png">
3. To open the special Task, click Confirm Organization-Wide Email Address

<img alt="My Tasks" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/29e4326b8c7a0af7460c32b12c69065b1161b7e6/docs/images/My_Tasks.png">

1. The task Comments contain the text of the verification email and a link to confirm the Organization-Wide Email Address. Click the link or copy and paste it into a browser to confirm the address.

<img alt="Confirm Address Task" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/37a1434f10e3ace13d2b82e7e4c328f6d5c22ae4/docs/images/Confirm_Address_Task.png">

After you click the link  or enter it into a browser, you see a message that the email is verified.

<img alt="Success Message" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/48bb79badf73359649ef86a1101fe5bd176e50d2/docs/images/Confirm_Message.png">

## Configure the Email in the Custom Metadata Type Record

From Setup, in the Quick Find box, enter Custom Metadata Types. Click the Manage Records link for the Referral Recommendations Setting custom metadata type you want.

<img alt="Custom Metadata Type" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/282de7c81db1fde98e14fda74481067db3501d7f/docs/images/Custom_Metadata_Type.png">

Edit the Organization Default record, then enter the email service’s email address into the Recommendations Email Service Address field.

<img alt="Referral Recommendations Setting" src="https://raw.githubusercontent.com/Salesforce-org-Impact-Labs/01HousingandHomelessness/282de7c81db1fde98e14fda74481067db3501d7f/docs/images/Referral_Recommendations_Setting.png">

# Schedule the Batch Jobs

To send referrals and referral followup messages to clients, schedule two batch jobs.

* Batch_SendInitialClientReferrals
* Batch_SendReferralFollowupReminders

To schedule the batch classes to execute at least once daily, see Salesforce Help, [Schedule Apex Jobs](https://help.salesforce.com/articleView?id=code_schedule_batch_apex.htm&type=5).

Suggested names for the jobs are:
  * Initial Referral
  * Referral Followup

You can schedule batch classes or you can run them at any time using the Execute Anonymous function in Salesforce. See Salesforce  Help for more information: [Executing Anonymous Apex Code](https://help.salesforce.com/articleView?id=code_dev_console_execute_anonymous.htm&type=5)

To execute the initial referral batch job, execute the following code snippet: refrec.Batch_SendInitialClientReferrals batchable = new refrec.Batch_SendInitialClientReferrals(); Database.executeBatch(batchable);

To execute the referral followup batch job, execute the following code snippet: refrec.Batch_SendReferralFollowupReminders batchable = new refrec.Batch_SendReferralFollowupReminders(); Database.executeBatch(batchable);

