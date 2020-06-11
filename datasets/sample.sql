BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('0011100001vL0ZiAAK','Test Provider 3');
INSERT INTO "Account" VALUES('0011100001vL0ZjAAK','Test Provider 1');
INSERT INTO "Account" VALUES('0011100001vL0ZkAAK','Test Provider 2');
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a001100000FRDHzAAP','2005-05-24','Micah','McLaughlin','94102','0031100001f1jgRAAQ');
INSERT INTO "Client_Profile__c" VALUES('a001100000FRDI0AAP','1979-04-20','Shane','McLaughlin','94102','0031100001f1jgSAAQ');
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
INSERT INTO "Contact" VALUES('0031100001f1jgRAAQ','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001f1jgSAAQ','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
INSERT INTO "Contact" VALUES('0031100001f1jkzAAA','Contact','WithoutProfile','8324728021','noprofile@mailinator.com','','false','false','false','');
CREATE TABLE "FeedItem" (
	sf_id VARCHAR(255) NOT NULL, 
	"Body" VARCHAR(255), 
	"Type" VARCHAR(255), 
	parent_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
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
	account__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
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
COMMIT;
