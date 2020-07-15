# Data Setup

You'll need some records in the org to get started. If you have an aggregator account with a supported aggregator,use that to import some providers and services. If you don't, you can create some manually as described below.

## Custom Metadata

In setup, under custom metadata, go to the **RefRecSettings** and **Manage Records**

Set your default latitude/longitude (unless your office is in the Salesforce Tower in San Francisco), max distance, and email address

## Account

Create one or more accounts that will represent a provider

## Services

In the Service\_\_c object, add one or more Services that the Provider provides and fill out all the information.
Be sure to populate its location fields (lat/long) with values close to where you sample contact is located
On the related tab, also add its operating hours.

## Contact

Create a contact to represent someone you want to create a referral for. Their geolocation (uses the Other Address field by default) and age needs to match the service to be able to see it.
