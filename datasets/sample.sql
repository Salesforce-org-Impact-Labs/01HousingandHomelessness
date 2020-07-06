BEGIN TRANSACTION;
CREATE TABLE "Account" (
	sf_id VARCHAR(255) NOT NULL, 
	"Name" VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Account" VALUES('0013F00000Z3VEoQAN','Test Provider 2');
INSERT INTO "Account" VALUES('0013F00000Z3VEmQAN','Test Provider 3');
INSERT INTO "Account" VALUES('0013F00000Z3VEnQAN','Test Provider 1');
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
	contact__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Client_Profile__c" VALUES('a003F000003xoCnQAI','2005-05-24','Micah','McLaughlin','94102','','','false','false','false','false','false','Unemployed','0033F00000Q9M60QAF');
INSERT INTO "Client_Profile__c" VALUES('a003F000003xoCoQAI','1979-04-20','Shane','McLaughlin','94102','','','false','false','false','false','false','Employed full-time','0033F00000Q9M61QAF');
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
INSERT INTO "Contact" VALUES('0033F00000Q9M60QAF','Micah','McLaughlin','8324728021','micah@mailinator.com','2005-05-24','false','false','false','');
INSERT INTO "Contact" VALUES('0033F00000Q9M61QAF','Shane','McLaughlin','8324728021','shane.m@mailinator.com','1979-04-20','false','false','false','');
INSERT INTO "Contact" VALUES('0033F00000Q9MBjQAN','Contact','WithoutProfile','8324728021','noprofile@mailinator.com','','false','false','false','');
INSERT INTO "Contact" VALUES('0033F00000Q9MBkQAN','Test 1','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('0033F00000Q9MBlQAN','Test 3','Contact','','','','false','false','false','');
INSERT INTO "Contact" VALUES('0033F00000Q9MBmQAN','Test 2','Contact','','','','false','false','false','');
CREATE TABLE "FeedItem" (
	sf_id VARCHAR(255) NOT NULL, 
	"Body" VARCHAR(255), 
	"Type" VARCHAR(255), 
	parent_id VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "FeedItem" VALUES('0D53F00000V6XNUSA3','<p>Here is another comment</p>','TextPost','a053F0000045uGgQAI');
INSERT INTO "FeedItem" VALUES('0D53F00000V6XNTSA3','<p>This one is my favorite</p>','TextPost','a053F0000045uGgQAI');
CREATE TABLE "Open_Hours__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"End_Time__c" VARCHAR(255), 
	"Start_Time__c" VARCHAR(255), 
	"Day__c" VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Open_Hours__c" VALUES('a013F000005rrF1QAI','17:00:00.000Z','09:00:00.000Z','Thursday','a053F0000045uGhQAI');
INSERT INTO "Open_Hours__c" VALUES('a013F000005rrF2QAI','17:00:00.000Z','09:00:00.000Z','Tuesday','a053F0000045uGhQAI');
INSERT INTO "Open_Hours__c" VALUES('a013F000005rrF3QAI','17:00:00.000Z','09:00:00.000Z','Monday','a053F0000045uGhQAI');
INSERT INTO "Open_Hours__c" VALUES('a013F000005rrF4QAI','17:00:00.000Z','09:00:00.000Z','Wednesday','a053F0000045uGhQAI');
CREATE TABLE "Referral__c" (
	sf_id VARCHAR(255) NOT NULL, 
	"Preferred_Channel__c" VARCHAR(255), 
	"Score__c" VARCHAR(255), 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Referral__c" VALUES('a033F0000046eogQAA','Email','','0033F00000Q9M60QAF','a053F0000045uGgQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eohQAA','SMS','3.0','0033F00000Q9M61QAF','a053F0000045uGhQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eoiQAA','SMS','','0033F00000Q9MBkQAN','a053F0000045uGeQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eojQAA','SMS','','0033F00000Q9MBkQAN','a053F0000045uGgQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eokQAA','SMS','3.0','0033F00000Q9MBlQAN','a053F0000045uGhQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eolQAA','SMS','1.0','0033F00000Q9MBmQAN','a053F0000045uGfQAI');
INSERT INTO "Referral__c" VALUES('a033F0000046eomQAA','SMS','3.0','0033F00000Q9MBmQAN','a053F0000045uGiQAI');
CREATE TABLE "Service_Exclusion__c" (
	sf_id VARCHAR(255) NOT NULL, 
	contact__c VARCHAR(255), 
	service__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service_Exclusion__c" VALUES('a043F0000038vvVQAQ','','a053F0000045uGeQAI');
INSERT INTO "Service_Exclusion__c" VALUES('a043F0000038vvWQAQ','','a053F0000045uGiQAI');
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
	account__c VARCHAR(255), 
	PRIMARY KEY (sf_id)
);
INSERT INTO "Service__c" VALUES('a053F0000045uGeQAI','hidden service (all contacts)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a053F0000045uGfQAI','far service','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Housing','www.google.com','94102','','false','2.0','-2.0','false','false','false','false','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a053F0000045uGgQAI','Test Service for Adults','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Food','www.google.com','94102','','false','37.7897','-122.397','true','true','true','true','true','true','true','true','true','');
INSERT INTO "Service__c" VALUES('a053F0000045uGhQAI','Test Service for Teens','17.0','13.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Education','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','false','false','false','false','');
INSERT INTO "Service__c" VALUES('a053F0000045uGiQAI','hidden service (only hidden from Shane)','','18.0','San Francisco','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut efficitur lacus in aliquet dignissim. Cras molestie risus vel magna gravida congue facilisis non nisl. Maecenas laoreet est libero, vitae cursus justo posuere in. Nunc vel elit sapien. Integer velit augue, volutpat ut mattis et, lacinia at orci.','555 555 5555','2400 Clay','Health','www.google.com','94102','','false','37.7897','-122.397','false','false','false','false','false','false','false','false','false','');
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
INSERT INTO "Task" VALUES('00T3F00000JpKcpUAF','Info to Client','','Completed','Normal','','a033F0000046eogQAA');
INSERT INTO "Task" VALUES('00T3F00000JpKcqUAF','Reminder','','Not Started','Normal','','a033F0000046eogQAA');
INSERT INTO "Task" VALUES('00T3F00000JpKcrUAF','Survey','','Not Started','Normal','','a033F0000046eogQAA');
COMMIT;
