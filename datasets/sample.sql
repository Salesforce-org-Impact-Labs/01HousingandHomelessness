BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('001S000001CBEYZIA5','Test Provider 3');
INSERT INTO "Account" VALUES('001S000001CBEYaIAP','Test Provider 1');
INSERT INTO "Account" VALUES('001S000001CBEYbIAP','Test Provider 2');
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	"Location__Latitude__s" VARCHAR(255), 
	"Location__Longitude__s" VARCHAR(255), 
	contact__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a00S0000007dUHBIA2','2005-05-24','Micah','McLaughlin','94102','','','003S000001LarKCIAZ');
INSERT INTO "Client_Profile__c" VALUES('a00S0000007dUHCIA2','1979-04-20','Shane','McLaughlin','94102','','','003S000001LarKDIAZ');
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
	reports_to_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Contact" VALUES('003S000001LarKCIAZ','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LarKDIAZ','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LarKEIAZ','Contact','WithoutProfile','8324728021','noprofile@mailinator.com','','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LarOQIAZ','Test 1','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LarHKIAZ','Test 3','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LarPSIAZ','Test 2','Contact','','','','false','false','false','');
CREATE TABLE "FeedItem" (
	sf_id VARCHAR(255) NOT NULL, 
	"Body" VARCHAR(255), 
	"Type" VARCHAR(255), 
	parent_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "FeedItem" VALUES('0D5S000000RU4uIKAT','<p>This one is my favorite</p>','TextPost','a04S0000009JpNcIAK');
INSERT INTO "FeedItem" VALUES('0D5S000000RU4uHKAT','<p>Here is another comment</p>','TextPost','a04S0000009JpNcIAK');
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Open_Hours__c" VALUES('a01S000000JktoMIAR','17:00:00.000Z','09:00:00.000Z','Thursday','a04S0000009JpNdIAK');
INSERT INTO "Open_Hours__c" VALUES('a01S000000JktoNIAR','17:00:00.000Z','09:00:00.000Z','Tuesday','a04S0000009JpNdIAK');
INSERT INTO "Open_Hours__c" VALUES('a01S000000JktoOIAR','17:00:00.000Z','09:00:00.000Z','Monday','a04S0000009JpNdIAK');
INSERT INTO "Open_Hours__c" VALUES('a01S000000JktoPIAR','17:00:00.000Z','09:00:00.000Z','Wednesday','a04S0000009JpNdIAK');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a02S000000EjCvNIAV','Email','','003S000001LarKCIAZ','a04S0000009JpNcIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvOIAV','SMS','3.0','003S000001LarKDIAZ','a04S0000009JpNdIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvcIAF','SMS','1.0','003S000001LarPSIAZ','a04S0000009JpNbIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvhIAF','SMS','3.0','003S000001LarPSIAZ','a04S0000009JpNeIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvXIAV','SMS','3.0','003S000001LarHKIAZ','a04S0000009JpNdIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvYIAV','SMS','','003S000001LarOQIAZ','a04S0000009JpNcIAK');
INSERT INTO "Referral__c" VALUES('a02S000000EjCvZIAV','SMS','','003S000001LarOQIAZ','a04S0000009JpNaIAK');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a03S0000007KiR5IAK','','a04S0000009JpNaIAK');
INSERT INTO "Service_Exclusion__c" VALUES('a03S0000007KiR6IAK','','a04S0000009JpNeIAK');
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
	account__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a04S0000009JpNaIAK','hidden service (all contacts)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','37.7897','-122.397','');
INSERT INTO "Service__c" VALUES('a04S0000009JpNbIAK','far service','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','2.0','-2.0','');
INSERT INTO "Service__c" VALUES('a04S0000009JpNcIAK','Test Service for Adults','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Food','www.google.com','94102','','false','37.7897','-122.397','');
INSERT INTO "Service__c" VALUES('a04S0000009JpNdIAK','Test Service for Teens','17.0','13.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Education','www.google.com','94102','','false','37.7897','-122.397','');
INSERT INTO "Service__c" VALUES('a04S0000009JpNeIAK','hidden service (only hidden from Shane)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Health','www.google.com','94102','','false','37.7897','-122.397','');
CREATE TABLE "Task" (
	sf_id VARCHAR(255) NOT NULL, 
	"Subject" VARCHAR(255), 
	"Description" VARCHAR(255), 
	"Status" VARCHAR(255), 
	"Priority" VARCHAR(255), 
	who_id VARCHAR(255), 
	what_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Task" VALUES('00TS000000cMiJ4MAK','Info to Client','','Completed','Normal','','a02S000000EjCvNIAV');
INSERT INTO "Task" VALUES('00TS000000cMiJ5MAK','Reminder','','Not Started','Normal','','a02S000000EjCvNIAV');
INSERT INTO "Task" VALUES('00TS000000cMiJ6MAK','Survey','','Not Started','Normal','','a02S000000EjCvNIAV');
COMMIT;
