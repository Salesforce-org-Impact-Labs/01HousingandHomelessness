BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('0011100001vqJwAAAU','Test Provider 3');
INSERT INTO "Account" VALUES('0011100001vqJwBAAU','Test Provider 1');
INSERT INTO "Account" VALUES('0011100001vqJwCAAU','Test Provider 2');
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
	contact__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a001100000FSejMAAT','2005-05-24','Micah','McLaughlin','94102','','','false','false','false','false','false','0031100001ffeU1AAI');
INSERT INTO "Client_Profile__c" VALUES('a001100000FSejNAAT','1979-04-20','Shane','McLaughlin','94102','','','false','false','false','false','false','0031100001ffeU2AAI');
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
INSERT INTO "Contact" VALUES('0031100001ffeU1AAI','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001ffeU2AAI','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001ffeU3AAI','Contact','WithoutProfile','8324728021','noprofile@mailinator.com','','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001ffeU4AAI','Test 1','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001ffeV1AAI','Test 3','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001ffeV2AAI','Test 2','Contact','','','','false','false','false','');
CREATE TABLE "FeedItem" (
	sf_id VARCHAR(255) NOT NULL, 
	"Body" VARCHAR(255), 
	"Type" VARCHAR(255), 
	parent_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "FeedItem" VALUES('0D51100000jRqGoCAK','<p>This one is my favorite</p>','TextPost','a0511000009MhizAAC');
INSERT INTO "FeedItem" VALUES('0D51100000jRqGpCAK','<p>Here is another comment</p>','TextPost','a0511000009MhizAAC');
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Open_Hours__c" VALUES('a011100000igZywAAE','17:00:00.000Z','09:00:00.000Z','Thursday','a0511000009Mhj0AAC');
INSERT INTO "Open_Hours__c" VALUES('a011100000igZyxAAE','17:00:00.000Z','09:00:00.000Z','Tuesday','a0511000009Mhj0AAC');
INSERT INTO "Open_Hours__c" VALUES('a011100000igZyyAAE','17:00:00.000Z','09:00:00.000Z','Monday','a0511000009Mhj0AAC');
INSERT INTO "Open_Hours__c" VALUES('a011100000igZyzAAE','17:00:00.000Z','09:00:00.000Z','Wednesday','a0511000009Mhj0AAC');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a0311000009dalLAAQ','SMS','3.0','0031100001ffeV1AAI','a0511000009Mhj0AAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalMAAQ','Email','','0031100001ffeU1AAI','a0511000009MhizAAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalNAAQ','SMS','3.0','0031100001ffeU2AAI','a0511000009Mhj0AAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalOAAQ','SMS','','0031100001ffeU4AAI','a0511000009MhixAAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalPAAQ','SMS','','0031100001ffeU4AAI','a0511000009MhizAAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalQAAQ','SMS','1.0','0031100001ffeV2AAI','a0511000009MhiyAAC');
INSERT INTO "Referral__c" VALUES('a0311000009dalRAAQ','SMS','3.0','0031100001ffeV2AAI','a0511000009Mhj1AAC');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a041100000GnUYJAA3','','a0511000009MhixAAC');
INSERT INTO "Service_Exclusion__c" VALUES('a041100000GnUYKAA3','','a0511000009Mhj1AAC');
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
	account__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a0511000009MhixAAC','hidden service (all contacts)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a0511000009MhiyAAC','far service','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','2.0','-2.0','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a0511000009MhizAAC','Test Service for Adults','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Food','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a0511000009Mhj0AAC','Test Service for Teens','17.0','13.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Education','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a0511000009Mhj1AAC','hidden service (only hidden from Shane)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Health','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','');
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
INSERT INTO "Task" VALUES('00T1100000OxrlOEAR','Info to Client','','Completed','Normal','','a0311000009dalMAAQ');
INSERT INTO "Task" VALUES('00T1100000OxrlPEAR','Reminder','','Not Started','Normal','','a0311000009dalMAAQ');
INSERT INTO "Task" VALUES('00T1100000OxrlQEAR','Survey','','Not Started','Normal','','a0311000009dalMAAQ');
COMMIT;
