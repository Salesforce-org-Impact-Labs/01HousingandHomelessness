BEGIN TRANSACTION;
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a00J000000NVn2VIAT','1979-04-20','Shane','McLaughlin','94102');
INSERT INTO "Client_Profile__c" VALUES('a00J000000NVn2WIAT','2005-05-24','Micah','McLaughlin','94102');
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
INSERT INTO "Contact" VALUES('003J000001tBnUEIA0','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('003J000001tBnUFIA0','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a01J000001bv4qgIAA','Email','','003J000001tBnUFIA0','a02J000000Si2EHIAZ');
INSERT INTO "Referral__c" VALUES('a01J000001bv4qhIAA','SMS','','003J000001tBnUEIA0','a02J000000Si2EIIAZ');
CREATE TABLE "Service__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"Maximum_Age__c" VARCHAR(255), 
	"Minimum_Age__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a02J000000Si2EHIAZ','Test Service for Adults','','18.0');
INSERT INTO "Service__c" VALUES('a02J000000Si2EIIAZ','Test Service for Teens','17.0','13.0');
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
INSERT INTO "Task" VALUES('00TJ000000kTCzdMAG','Info to Client','','Completed','Normal','003J000001tBnUFIA0','a01J000001bv4qgIAA');
INSERT INTO "Task" VALUES('00TJ000000kTCziMAG','Reminder','','Not Started','Normal','003J000001tBnUFIA0','a01J000001bv4qgIAA');
INSERT INTO "Task" VALUES('00TJ000000kTCzjMAG','Survey','','Not Started','Normal','003J000001tBnUFIA0','a01J000001bv4qgIAA');
COMMIT;
