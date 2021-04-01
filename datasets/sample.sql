BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('0010x00001EBvbBAAT','Sample Account for Entitlements');
INSERT INTO "Account" VALUES('0010x00001EBvbLAAT','Test Provider 2');
INSERT INTO "Account" VALUES('0010x00001EBvbMAAT','Test Provider 3');
INSERT INTO "Account" VALUES('0010x00001EBvbNAAT','Test Provider 1');
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	"Location__Latitude__s" VARCHAR(255), 
	"Location__Longitude__s" VARCHAR(255), 
	"Homeless__c" VARCHAR(255), 
	"Runaway__c" VARCHAR(255), 
	"Home_Owner__c" VARCHAR(255), 
	"Home_Renter__c" VARCHAR(255), 
	"Near_Homeless__c" VARCHAR(255), 
	"Employment__c" VARCHAR(255), 
	"Contact__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a000x000009EZvMAAW','2005-05-24','Micah','McLaughlin','94102','','','False','False','False','False','False','Unemployed','0030x00000yV5tYAAS');
INSERT INTO "Client_Profile__c" VALUES('a000x000009EZvNAAW','1979-04-20','Shane','McLaughlin','94102','','','False','False','False','True','False','Employed full-time','0030x00000yV5tZAAS');
INSERT INTO "Client_Profile__c" VALUES('a000x000009EZvRAAW','','Test 1','Contact','','','','False','False','False','False','False','','0030x00000yV5tbAAC');
CREATE TABLE "Contact" (
	sf_id VARCHAR(255) NOT NULL, 
	"FirstName" VARCHAR(255), 
	"LastName" VARCHAR(255), 
	"MobilePhone" VARCHAR(255), 
	"Email" VARCHAR(255), 
	"BirthDate" VARCHAR(255), 
	"DoNotCall" VARCHAR(255), 
	"HasOptedOutOfEmail" VARCHAR(255), 
	"HasOptedOutOfFax" VARCHAR(255), 
	"ReportsToId" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Contact" VALUES('0030x00000yV5tYAAS','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','False','False','False','');
INSERT INTO "Contact" VALUES('0030x00000yV5tZAAS','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','False','False','False','');
INSERT INTO "Contact" VALUES('0030x00000yV5taAAC','Contact','WithoutProfile','8324728021','noprofile@mailinator.com','','False','False','False','');
INSERT INTO "Contact" VALUES('0030x00000yV5tbAAC','Test 1','Contact','','','','False','False','False','');
INSERT INTO "Contact" VALUES('0030x00000yV5tcAAC','Test 3','Contact','','','','False','False','False','');
INSERT INTO "Contact" VALUES('0030x00000yV5tdAAC','Test 2','Contact','','','','False','False','False','');
CREATE TABLE "FeedItem" (
	sf_id VARCHAR(255) NOT NULL, 
	"Body" VARCHAR(255), 
	"Type" VARCHAR(255), 
	"ParentId" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "FeedItem" VALUES('0D50x00000juO0jCAE','<p>This one is my favorite</p>','TextPost','a050x000003AdgsAAC');
INSERT INTO "FeedItem" VALUES('0D50x00000juO0iCAE','<p>Here is another comment</p>','TextPost','a050x000003AdgsAAC');
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	"Service__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Open_Hours__c" VALUES('a010x000006zGYmAAM','17:00:00.000Z','09:00:00.000Z','Thursday','a050x000003AdgtAAC');
INSERT INTO "Open_Hours__c" VALUES('a010x000006zGYnAAM','17:00:00.000Z','09:00:00.000Z','Tuesday','a050x000003AdgtAAC');
INSERT INTO "Open_Hours__c" VALUES('a010x000006zGYoAAM','17:00:00.000Z','09:00:00.000Z','Monday','a050x000003AdgtAAC');
INSERT INTO "Open_Hours__c" VALUES('a010x000006zGYpAAM','17:00:00.000Z','09:00:00.000Z','Wednesday','a050x000003AdgtAAC');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	"Contact__c" VARCHAR(255), 
	"Service__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a030x000004CQhfAAG','Email','','0030x00000yV5tYAAS','a050x000003AdgsAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhgAAG','SMS','3.0','0030x00000yV5tZAAS','a050x000003AdgtAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhhAAG','SMS','','0030x00000yV5tbAAC','a050x000003AdgqAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhiAAG','SMS','','0030x00000yV5tbAAC','a050x000003AdgsAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhjAAG','SMS','3.0','0030x00000yV5tcAAC','a050x000003AdgtAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhkAAG','SMS','1.0','0030x00000yV5tdAAC','a050x000003AdgrAAC');
INSERT INTO "Referral__c" VALUES('a030x000004CQhlAAG','SMS','3.0','0030x00000yV5tdAAC','a050x000003AdguAAC');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Contact__c" VARCHAR(255), 
	"Service__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a040x000003vc4eAAA','','a050x000003AdgqAAC');
INSERT INTO "Service_Exclusion__c" VALUES('a040x000003vc4fAAA','','a050x000003AdguAAC');
CREATE TABLE "Service__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"Maximum_Age__c" VARCHAR(255), 
	"Minimum_Age__c" VARCHAR(255), 
	"City__c" VARCHAR(255), 
	"Description__c" VARCHAR(255), 
	"Phone__c" VARCHAR(255), 
	"Street__c" VARCHAR(255), 
	"Type__c" VARCHAR(255), 
	"Website__c" VARCHAR(255), 
	"Zip_Code__c" VARCHAR(255), 
	"External_ID__c" VARCHAR(255), 
	"Preferred__c" VARCHAR(255), 
	"Location__Latitude__s" VARCHAR(255), 
	"Location__Longitude__s" VARCHAR(255), 
	"Homeless__c" VARCHAR(255), 
	"Runaway__c" VARCHAR(255), 
	"Home_Owner__c" VARCHAR(255), 
	"Home_Renter__c" VARCHAR(255), 
	"Near_Homeless__c" VARCHAR(255), 
	"Unemployed__c" VARCHAR(255), 
	"Retired__c" VARCHAR(255), 
	"Employed_part_time__c" VARCHAR(255), 
	"Employed_full_time__c" VARCHAR(255), 
	"Account__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a050x000003AdgqAAC','hidden service (all contacts)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','False','37.7897','-122.397','False','False','False','False','False','False','False','False','False','');
INSERT INTO "Service__c" VALUES('a050x000003AdgrAAC','far service','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','False','2.0','-2.0','False','False','False','False','False','False','False','False','False','');
INSERT INTO "Service__c" VALUES('a050x000003AdgsAAC','Test Service for Adults','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Food','www.google.com','94102','','False','37.7897','-122.397','True','True','True','True','True','True','True','True','True','');
INSERT INTO "Service__c" VALUES('a050x000003AdgtAAC','Test Service for Teens','17.0','13.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Education','www.google.com','94102','','False','37.7897','-122.397','False','False','False','False','False','False','False','False','False','');
INSERT INTO "Service__c" VALUES('a050x000003AdguAAC','hidden service (only hidden from Shane)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Health','www.google.com','94102','','False','37.7897','-122.397','False','False','False','False','False','False','False','False','False','');
CREATE TABLE "Task" (
	sf_id VARCHAR(255) NOT NULL, 
	"Subject" VARCHAR(255), 
	"Description" VARCHAR(255), 
	"Status" VARCHAR(255), 
	"Priority" VARCHAR(255), 
	"WhoId" VARCHAR(255), 
	"WhatId" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Task" VALUES('00T0x00000RDBdOEAX','Info to Client','','Completed','Normal','','a030x000004CQhfAAG');
INSERT INTO "Task" VALUES('00T0x00000RDBdPEAX','Reminder','','Not Started','Normal','','a030x000004CQhfAAG');
INSERT INTO "Task" VALUES('00T0x00000RDBdQEAX','Survey','','Not Started','Normal','','a030x000004CQhfAAG');
COMMIT;
