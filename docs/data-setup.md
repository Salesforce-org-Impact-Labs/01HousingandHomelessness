# Data Setup

To import provider and service records, you can use an aggregator account with a supported aggregator or  you can create records manually.


## Custom Metadata

From Setup, search for Custom Metadata Types in the Quick Find box. Select Manage Records on the Referral Recommendations Setting. 

Edit the Organizational Defaults and set your default latitude/longitude , your maximum distance, and email address.

To use a tool to find coordinates for your default address, see: [Latitude and Longitude Finder on Map Get Coordinates](https://www.latlong.net/).


## Account

Create one or more accounts to represent providers

## Services

In the refrec__Service__c object, add one or more Services that the Provider provides and fill out all the information. Be sure to populate its location fields (lat/long) with values close to where you sample contact is located 

On the related tab, also add its operating hours.

## Contact

Create a contact to represent someone you want to create a referral for. Their geolocation (uses the Other Address field by default) and age needs to match the service to be able to see it.
