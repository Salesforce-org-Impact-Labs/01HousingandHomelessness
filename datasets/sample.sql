BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('001S000001ByGRNIA3','Test Provider 3');
INSERT INTO "Account" VALUES('001S000001ByGKaIAN','Test Provider 1');
INSERT INTO "Account" VALUES('001S000001ByGMnIAN','Test Provider 2');
CREATE TABLE "Client_Profile__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Date_of_Birth__c" VARCHAR(255), 
	"First_Name__c" VARCHAR(255), 
	"Last_Name__c" VARCHAR(255), 
	"Postal_Code__c" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a00S0000007dDuWIAU','1979-04-20','Shane','McLaughlin','94102');
INSERT INTO "Client_Profile__c" VALUES('a00S0000007dDuXIAU','2005-05-24','Micah','McLaughlin','94102');
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
INSERT INTO "Contact" VALUES('003S000001LQdpiIAD','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('003S000001LQdpjIAD','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Open_Hours__c" VALUES('a04S0000009JTjwIAG','17:00:00.000Z','09:00:00.000Z','Thursday','a03S0000007JsyYIAS');
INSERT INTO "Open_Hours__c" VALUES('a04S0000009JTjmIAG','17:00:00.000Z','09:00:00.000Z','Tuesday','a03S0000007JsyYIAS');
INSERT INTO "Open_Hours__c" VALUES('a04S0000009JTjhIAG','17:00:00.000Z','09:00:00.000Z','Monday','a03S0000007JsyYIAS');
INSERT INTO "Open_Hours__c" VALUES('a04S0000009JTjrIAG','17:00:00.000Z','09:00:00.000Z','Wednesday','a03S0000007JsyYIAS');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a01S000000Jjnr0IAB','SMS','','003S000001LQdpiIAD','a03S0000007JsyYIAS');
INSERT INTO "Referral__c" VALUES('a01S000000Jjnr1IAB','Email','','003S000001LQdpjIAD','a03S0000007JsyXIAS');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a02S000000EgcfSIAR','','a03S0000007JsyZIAS');
INSERT INTO "Service_Exclusion__c" VALUES('a02S000000EgcfTIAR','003S000001LQdpjIAD','a03S0000007JsyWIAS');
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
	account__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a03S0000007JsyWIAS','hidden service (only hidden from Shane)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Health','www.google.com','94102','','001S000001ByGMnIAN');
INSERT INTO "Service__c" VALUES('a03S0000007JsyXIAS','Test Service for Adults','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Food','www.google.com','94102','','001S000001ByGKaIAN');
INSERT INTO "Service__c" VALUES('a03S0000007JsyYIAS','Test Service for Teens','17.0','13.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Education','www.google.com','94102','','001S000001ByGKaIAN');
INSERT INTO "Service__c" VALUES('a03S0000007JsyZIAS','hidden service (all contacts)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','001S000001ByGRNIA3');
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
INSERT INTO "Task" VALUES('00TS000000cMMxaMAG','Info to Client','','Completed','Normal','003S000001LQdpjIAD','a01S000000Jjnr1IAB');
INSERT INTO "Task" VALUES('00TS000000cMMxbMAG','Reminder','','Not Started','Normal','003S000001LQdpjIAD','a01S000000Jjnr1IAB');
INSERT INTO "Task" VALUES('00TS000000cMMxcMAG','Survey','','Not Started','Normal','003S000001LQdpjIAD','a01S000000Jjnr1IAB');
COMMIT;
