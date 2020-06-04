BEGIN TRANSACTION;
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a000R0000033qybQAA','1979-04-20','Shane','McLaughlin','94102');
INSERT INTO "Client_Profile__c" VALUES('a000R0000033qycQAA','2005-05-24','Micah','McLaughlin','94102');
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
INSERT INTO "Contact" VALUES('0030R000012KGQPQA4','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('0030R000012KGQQQA4','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a010R000008MvbPQAS','SMS','','0030R000012KGQPQA4','a020R00000O75mYQAR');
INSERT INTO "Referral__c" VALUES('a010R000008MvbQQAS','Email','','0030R000012KGQQQA4','a020R00000O75mXQAR');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a030R000006KH0QQAW','0030R000012KGQQQA4','a020R00000O75vqQAB');
INSERT INTO "Service_Exclusion__c" VALUES('a030R000006KH0RQAW','','a020R00000O75qjQAB');
CREATE TABLE "Service__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"Maximum_Age__c" VARCHAR(255), 
	"Minimum_Age__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a020R00000O75vqQAB','hidden service (only hidden from Shane)','','');
INSERT INTO "Service__c" VALUES('a020R00000O75mXQAR','Test Service for Adults','','18.0');
INSERT INTO "Service__c" VALUES('a020R00000O75mYQAR','Test Service for Teens','17.0','13.0');
INSERT INTO "Service__c" VALUES('a020R00000O75qjQAB','hidden service (all contacts)','','');
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
INSERT INTO "Task" VALUES('00T0R00000NZvHTUA1','Info to Client','','Completed','Normal','0030R000012KGQQQA4','a010R000008MvbQQAS');
INSERT INTO "Task" VALUES('00T0R00000NZvHUUA1','Reminder','','Not Started','Normal','0030R000012KGQQQA4','a010R000008MvbQQAS');
INSERT INTO "Task" VALUES('00T0R00000NZvHVUA1','Survey','','Not Started','Normal','0030R000012KGQQQA4','a010R000008MvbQQAS');
COMMIT;
