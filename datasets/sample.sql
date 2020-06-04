BEGIN TRANSACTION;
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a003B000004d1uvQAA','1979-04-20','Shane','McLaughlin','94102');
INSERT INTO "Client_Profile__c" VALUES('a003B000004d1qcQAA','2005-05-24','Micah','McLaughlin','94102');
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
INSERT INTO "Contact" VALUES('0033B00000TumbhQAB','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('0033B00000TumbcQAB','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a013B000005n8JXQAY','Email','','0033B00000TumbcQAB','a023B000002e31fQAA');
INSERT INTO "Referral__c" VALUES('a013B000005n8JSQAY','SMS','','0033B00000TumbhQAB','a023B000002e31kQAA');
CREATE TABLE "Service__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	"Maximum_Age__c" VARCHAR(255), 
	"Minimum_Age__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a023B000002e31fQAA','Test Service for Adults','','18.0');
INSERT INTO "Service__c" VALUES('a023B000002e31kQAA','Test Service for Teens','17.0','13.0');
COMMIT;
