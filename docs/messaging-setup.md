# Messaging Setup

Temporary docs in quip
<https://salesforce.quip.com/DrwyASzKil86>

# Configuring an Email Service for the Client Recommendations Inbound Email Handler

This may feel like lot to do and it may force you to visit screens with which you aren’t usually familiar, but take heart - this is a one-time task that should take you only about 15 minutes.

## Create the Email Service

Search setup for “Email Services”, then create a New Email Service
[Image: Screen Shot 2020-06-19 at 1.10.48 PM.png]

* The Service Name can be anything meaningful. Here, we’ve used “Client Referral Email Service”
* The Apex Class must be **RecommendationsInboundEmailHandler**
* Be sure to check the box to make the service Active!

### Create a new Email Address

[Image: Screen Shot 2020-06-19 at 1.12.30 PM.png]

* Email Address Name and Email Address: We’ve kept the email name and address consistent with the name of the email service, but that isn’t necessary. You can give it any name that is meaningful to you.
* Be sure to Activate the address
* Context User: Choose a user that has System Administrator privileges. This user will be the owner of any record created by the inbound email handler.
    * We suggest that you create a special User for this purpose, one that would never become Inactive.

## Create the Org Wide Email Address

After the Email Address is created, we need to make it an Org-Wide Email so that we can use this email address as the “Reply-To” email in our messages to the Client.
[Image: Screen Shot 2020-06-19 at 1.19.47 PM.png]Get the email address, create an org-wide email for that address. **Hint**: name it something to match your organization!

Search Setup for “Organization-Wide Email Address”
[Image: Screen Shot 2020-07-08 at 9.23.36 AM.png]

1. Choose a meaningful Display Name - perhaps the name of your organization - this will appear as the Sender for messages that are sent by the system.
2. Copy the Email Address created above, when you were setting up the Email Service - it will be a very long email address.
3. Choose the profiles that may use this address - be sure you include the Profile of the Context User.

## Confirm the Organization-Wide Email Address

In order for the Organization-Wide email be be activated, that email address must first be validated.
[Image: Screen Shot 2020-06-19 at 1.29.02 PM.png]Because the “recipient” of this org-wide email is the system itself, we’ve tried to make it easy for you to validate the address.

When the Email Service handler code receives a request to validate the email address, it will create a Task. This Task will be assigned to the Context User that you’ve specified above, when you created the Email Address.


1. Log in as the Context User and navigate to the Home tab, where you can view the Tasks that have been assigned to this user.
2. Open the special Task by clicking on the Subject, “Confirm Organization-Wide Email Address”

[Image: Screen Shot 2020-07-16 at 1.57.56 PM.png]

1. The Comments of the task will contain the text of the verification email. In the text will be a link to confirm the Organization-Wide Email Address. Click the link or copy and paste it into a browser to confirm the address.

[Image: Screen Shot 2020-07-16 at 1.59.47 PM.png]
When the link is clicked or entered into a browser, you should see a success message
[Image: Screen Shot 2020-06-19 at 1.33.27 PM.png]

## Configure the Email in the Custom Metadata Type Record

Use the Quick Find capability in setup to search for “Custom Metadata Types”. Once you’re on the “All Custom Metadata Types” page, click the “Manage Records” link for the Referral Recommendations Setting custom metadata type. 
[Image: Screen Shot 2020-07-16 at 2.10.01 PM.png]
Edit the Organization Default record, then enter the email service’s email address into the “Recommendations Email Service Address” field..
[Image: Screen Shot 2020-06-19 at 3.03.14 PM.png]

