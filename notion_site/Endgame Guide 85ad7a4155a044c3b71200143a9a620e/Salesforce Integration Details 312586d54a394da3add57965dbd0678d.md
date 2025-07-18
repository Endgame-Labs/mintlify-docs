# Salesforce Integration Details

## Authentication

Endgame authenticates users via Salesforce OAuth. This allows for a seamless and secure user experience by leveraging Salesforce's robust authentication framework.

## Data ingestion

Endgame leverages the Bulk API 2.0 fetch data from Salesforce on an hourly basis—which means integration is generally immaterial when it comes to API limits. We ingest the objects outlined below by default—but it’s also possible to explicitly define additional objects as needed. After the initial sync, we constrain subsequent requests to records that have been updated (as determined by SystemModStamp).

Endgame polls for the query job to complete with incremental backoffs starting at every one minute and going up to ten minutes between job completion poll attempts.

Endgame also downloads the results using a page size of 25,000, downloading those pages in parallel.

Data from Salesforce is fetched using the credentials of the first user to log into Endgame. If needed, these credentials can be updated to a different user by sending a request to support@endgame.io. 

<aside>
💡

Only accounts the integration user has permission to in Salesforce will be run through any AI systems. The integration user is the one you first log in with after consultation with Endgame.

</aside>

## Default objects

Endgame ingests a number of Salesforce objects by default, but please note that additional objects may be added in the future to enable additional functionality. 

- Account
- User
- Lead
- Contact
- Opportunity
- Task
- Event
- RecordType
- OpportunityLineItem
- OpportunityContactRole
- Campaign
- CampaignMember
- Note
- OpportunityHistory