
# -----CREATE SCHEMA---- #

drop schema if exists olympics;
create schema olympics;
use olympics;

#create country table
CREATE TABLE `country` (
  `countryID` int(11) NOT NULL AUTO_INCREMENT,
  `countryName` varchar(45) NOT NULL,
  PRIMARY KEY (`countryID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

#create sports table
CREATE TABLE `sports` (
  `sportsID` int(11) NOT NULL AUTO_INCREMENT,
  `sportsName` varchar(300) NOT NULL,
  `sportsIcon` varchar(400),
  `seazon` enum('SUMMER','WINTER') NOT NULL,
  PRIMARY KEY (`sportsID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#create athlet table
CREATE TABLE `athlet` (
  `athletID` int(11) NOT NULL AUTO_INCREMENT,
  `athletName` varchar(45) NOT NULL,
  `athletLastName` varchar(45) NOT NULL,
  `athletDOB` date NOT NULL,
  `athletGender` enum('MALE','FEMALE') NOT NULL,
  #athlets dont always represent a country therfore null is allowed
  `athletCountryID` int(11) DEFAULT NULL,
  PRIMARY KEY (`athletID`),
  KEY `athleteCountryID_idx` (`athletCountryID`),
  CONSTRAINT `athleteCountryID` FOREIGN KEY (`athletCountryID`) REFERENCES `country` (`countryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#create team table
CREATE TABLE `team` (
  `teamID` int(11) NOT NULL AUTO_INCREMENT,
  `teamName` varchar(100) NOT NULL,
  `teamCountryID` int(11) DEFAULT NULL,
  `flag` longblob,
  PRIMARY KEY (`teamID`),
  KEY `teamCountry_idx` (`teamCountryID`),
  CONSTRAINT `teamCountry` FOREIGN KEY (`teamCountryID`) REFERENCES `country` (`countryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#create team-member table (linking between athlet and team)
CREATE TABLE `team_member` (
  `teamMemberTeamId` int(11) NOT NULL,
  `teamMemberAthletId` int(11) NOT NULL,
  PRIMARY KEY (`teamMemberTeamId`,`teamMemberAthletId`),
  KEY `athlet_idx` (`teamMemberAthletId`),
  CONSTRAINT `athlet` FOREIGN KEY (`teamMemberAthletId`) REFERENCES `athlet` (`athletID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team` FOREIGN KEY (`teamMemberTeamId`) REFERENCES `team` (`teamID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#create venue table
CREATE TABLE `venue` (
  `venueID` int(11) NOT NULL AUTO_INCREMENT,
  `VenueName` varchar(500) NOT NULL,
  `venueLocation` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`venueID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#create event table
CREATE TABLE `event` (
  `eventId` int(11) NOT NULL AUTO_INCREMENT,
  `eventSportID` int(11) NOT NULL,
  `eventName` varchar(500) NOT NULL,
  #event rank refares to stage (finall, semifinal, 1/8 elimination round...)
  #it is an int so that the progress of the event can be captured independant of the
  #different names given for it in each event (e.g. finall =1 , semifinal=2 and so on)
  `eventRank` int(11) DEFAULT NULL,
  `eventVenueId` int(11) NOT NULL,
  `eventDateTimeStart` datetime NOT NULL,
  `eventType` enum('TEAM','ATHLET') NOT NULL,
  `eventGroupe` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventId`),
  KEY `eventVenue_idx` (`eventVenueId`),
  KEY `eventSport_idx` (`eventSportID`),
  CONSTRAINT `eventSport` FOREIGN KEY (`eventSportID`) REFERENCES `sports` (`sportsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventVenue` FOREIGN KEY (`eventVenueId`) REFERENCES `venue` (`venueID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#create participance table (linking between athlet or team and event)
CREATE TABLE `participance` (
  `participanceId` int(11) NOT NULL AUTO_INCREMENT,
  `participanceEventID` int(11)NOT NULL,
  #either teamID or AthletID will need to be null for each participant
  `participanceTeamID` int(11) DEFAULT NULL,
  `participanceAthlet` int(11) DEFAULT NULL,
  `participanceRecord` varchar(100) DEFAULT NULL,
  `participanceRecordRank` int(11) DEFAULT NULL,
  `participanceNotes` varchar(20000) DEFAULT NULL,
  #this is a boolean to check if a participant will be in the awords ceremony
  #each event has different regulations on this topic (not always the three first, special cases on team events)
  #boolean is most flexible
  `participancPodium` int(11) DEFAULT NULL,
  PRIMARY KEY (`participanceId`),
  KEY `eventId_idx` (`participanceEventID`),
  KEY `participanceTeam_idx` (`participanceTeamID`),
  KEY `participanceAthlet_idx` (`participanceAthlet`),
  CONSTRAINT `participanceAthlet` FOREIGN KEY (`participanceAthlet`) REFERENCES `athlet` (`athletID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participanceEvent` FOREIGN KEY (`participanceEventID`) REFERENCES `event` (`eventId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participanceTeam` FOREIGN KEY (`participanceTeamID`) REFERENCES `team` (`teamID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


#create overall-record table
# (unormalized table that stores the final rank of each participant)
CREATE TABLE `overall_record_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventName` varchar(300) NOT NULL,
  `participanceRank` int(11) NOT NULL,
  `participanceName` varchar(400) NOT NULL,
  `participanceRecord` varchar(400) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;

# -----POPULATE DATA---- #

#insert some data on country
INSERT INTO country (`countryID`, `countryName`) VALUES (10, 'Sweden');
INSERT INTO country (`countryID`, `countryName`) VALUES (11, 'Australia');
INSERT INTO country (`countryID`, `countryName`) VALUES (12, 'Morocco');
INSERT INTO country (`countryID`, `countryName`) VALUES (13, 'American Samoa');
INSERT INTO country (`countryID`, `countryName`) VALUES (14, 'Antigua and Barbuda');
INSERT INTO country (`countryID`, `countryName`) VALUES (15, 'Switzerland');
INSERT INTO country (`countryID`, `countryName`) VALUES (16, 'Sudan');
INSERT INTO country (`countryID`, `countryName`) VALUES (17, 'Northern Mariana Islands');
INSERT INTO country (`countryID`, `countryName`) VALUES (18, 'Bosnia and Herzegovina');
INSERT INTO country (`countryID`, `countryName`) VALUES (19, 'Dominica');
INSERT INTO country (`countryID`, `countryName`) VALUES (20, 'Turks and Caicos Islands');
INSERT INTO country (`countryID`, `countryName`) VALUES (21, 'Bouvet Island (Bouvetoya)');
INSERT INTO country (`countryID`, `countryName`) VALUES (22, 'Bermuda');
INSERT INTO country (`countryID`, `countryName`) VALUES (23, 'Poland');
INSERT INTO country (`countryID`, `countryName`) VALUES (24, 'Croatia');
INSERT INTO country (`countryID`, `countryName`) VALUES (25, 'United States Virgin Islands');
INSERT INTO country (`countryID`, `countryName`) VALUES (26, 'Lesotho');
INSERT INTO country (`countryID`, `countryName`) VALUES (27, 'Liberia');
INSERT INTO country (`countryID`, `countryName`) VALUES (28, 'Brazil');
INSERT INTO country (`countryID`, `countryName`) VALUES (29, 'china');
INSERT INTO country (`countryID`, `countryName`) VALUES (30, 'Cyprus');
INSERT INTO country (`countryID`, `countryName`) VALUES (31, 'Morocco');
INSERT INTO country (`countryID`, `countryName`) VALUES (32, 'Brunei Darussalam');
INSERT INTO country (`countryID`, `countryName`) VALUES (33, 'UK');
INSERT INTO country (`countryID`, `countryName`) VALUES (34, 'France');

#insert some data for venues
INSERT INTO venue (`venueID`, `VenueName`, `venueLocation`) VALUES ('1', 'T.3.4', 'opposite of the tennis court');

#insert data for athlets
#females
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (21, 'Betty', 'Chapman', '1993-01-24', 'FEMALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (22, 'Sarah', 'Wagner', '1995-06-12', 'FEMALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (23, 'Andrea', 'Thompson', '1994-11-21', 'FEMALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (24, 'Denise', 'Gibson', '1996-11-14', 'FEMALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (25, 'Jacqueline', 'Gordon', '1996-05-02', 'FEMALE', 24);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (26, 'Jacqueline', 'Berry', '1995-03-07', 'FEMALE', 24);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (27, 'Brenda', 'Cruz', '1991-09-29', 'FEMALE', 24);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (28, 'Amanda', 'Richards', '1991-12-05', 'FEMALE', 24);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (29, 'Virginia', 'Porter', '1991-09-25', 'FEMALE', 30);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (30, 'Stephanie', 'Little', '1995-05-13', 'FEMALE', 30);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (31, 'Amanda', 'Cole', '1990-11-24', 'FEMALE', 30);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (32, 'Jean', 'Warren', '1995-09-08', 'FEMALE', 30);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (33, 'Diane', 'Ruiz', '1995-10-24', 'FEMALE', 33);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (34, 'Bonnie', 'Barnes', '1994-01-03', 'FEMALE', 33);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (35, 'Sara', 'Garrett', '1995-01-05', 'FEMALE', 33);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (36, 'Kimberly', 'Robertson', '1992-04-17', 'FEMALE', 33);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (37, 'Marilyn', 'Jacobs', '1996-06-02', 'FEMALE', 34);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (38, 'Jessica', 'Bryant', '1996-10-19', 'FEMALE', 34);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (39, 'Rebecca', 'Ferguson', '1990-11-30', 'FEMALE', 34);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (40, 'Janet', 'Williamson', '1992-06-01', 'FEMALE', 34);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (41, 'Anna', 'Williamson', '1992-06-01', 'FEMALE', NULL);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (42, 'Lilian', 'Williamson', '1992-06-01', 'FEMALE', NULL);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (43, 'Samm', 'Williamson', '1992-06-01', 'FEMALE', NULL);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (44, 'Janet', 'Williamson', '1992-06-01', 'FEMALE', NULL);

#males
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (1, 'Jeffrey', 'Richardson', '1993-02-01', 'MALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (2, 'Michael', 'Harrison', '1994-11-15', 'MALE', 33);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (3, 'Ryan', 'Hawkins', '1991-10-07', 'MALE', 24);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (4, 'Jason', 'Wallace', '1994-08-05', 'MALE', 28);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (5, 'Michael', 'Perry', '1995-01-14', 'MALE', 28);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (6, 'Michael', 'Perez', '1995-09-13', 'MALE', 20);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (7, 'Gregory', 'Henry', '1996-07-20', 'MALE', 11);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (8, 'Timothy', 'Jenkins', '1995-03-11', 'MALE', 34);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (9, 'Carl', 'Montgomery', '1991-05-10', 'MALE', 14);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (10, 'Russell', 'Mitchell', '1992-01-07', 'MALE', 18);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (11, 'David', 'Cole', '1991-05-23', 'MALE', 21);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (12, 'Joseph', 'Nichols', '1994-08-23', 'MALE', 12);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (13, 'Scott', 'Harvey', '1996-01-12', 'MALE', 23);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (14, 'Gerald', 'Hill', '1995-05-05', 'MALE', 10);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (15, 'Ryan', 'Vasquez', '1993-10-25', 'MALE', 30);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (16, 'Jonathan', 'Hanson', '1996-03-29', 'MALE', 18);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (17, 'Craig', 'Gonzalez', '1993-05-22', 'MALE', 27);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (18, 'Russell', 'Robinson', '1994-02-19', 'MALE', 11);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (19, 'Martin', 'Rodriguez', '1992-04-02', 'MALE', 14);
insert into athlet (athletID, athletName, athletLastName, athletDOB, athletGender, athletCountryID) values (20, 'Steven', 'Austin', '1992-06-14', 'MALE', 29);

#insert some data to teams
INSERT INTO team  VALUES ('3', 'Refugees women team', NULL,NULL);
INSERT INTO team  VALUES ('4', 'Croatia womans basketball team', '24',NULL);
INSERT INTO team  VALUES ('5', 'Poland women basketball team', '23', NULL);
INSERT INTO team  VALUES ('6', 'Cyprusr women basketball team', '30',NULL);
INSERT INTO team  VALUES ('7', 'UK women basketball team', '33', NULL);
INSERT INTO team  VALUES ('8', 'France women basketball team', '34', NULL);
INSERT INTO team  VALUES ('9', 'Brazil women  basketball team', '28', NULL);
INSERT INTO team  VALUES ('10', 'china women basketball team', '29', NULL);

#insert some data in team members
INSERT INTO team_member values (3,41);
INSERT INTO team_member values (3,42);
INSERT INTO team_member values (3,43);
INSERT INTO team_member values (3,44);
INSERT INTO team_member values (5,21);
INSERT INTO team_member values (5,22);
INSERT INTO team_member values (5,23);
INSERT INTO team_member values (5,24);
INSERT INTO team_member values (4,25);
INSERT INTO team_member values (4,26);
INSERT INTO team_member values (4,27);
INSERT INTO team_member values (4,28);
INSERT INTO team_member values (6,29);
INSERT INTO team_member values (6,30);
INSERT INTO team_member values (6,31);
INSERT INTO team_member values (6,32);
INSERT INTO team_member values (7,33);
INSERT INTO team_member values (7,34);
INSERT INTO team_member values (7,35);
INSERT INTO team_member values (7,36);
INSERT INTO team_member values (8,37);
INSERT INTO team_member values (8,38);
INSERT INTO team_member values (8,39);
INSERT INTO team_member values (8,40);

#insert some values for sports
INSERT INTO sports values (4,'basketball','https://cdn4.iconfinder.com/data/icons/basketball-3/500/Basketball_14-128.png','SUMMER');
INSERT INTO sports values (1,'weightlifting','https://cdn0.iconfinder.com/data/icons/sports-43/281/sport-sports_129-128.png','SUMMER');
INSERT INTO sports values (2,'athletics','http://uploads.webflow.com/56a1d83c6c393b707c208473/57e3473e8fcfc4143a491403_man-sprinting.png','SUMMER');
INSERT INTO sports values (3,'swimming','https://cdn4.iconfinder.com/data/icons/sports-recreation/128/swimming-2-128.png','SUMMER');
INSERT INTO sports values (5,'football','http://icons.iconarchive.com/icons/icons8/windows-8/128/Sports-Football-icon.png','SUMMER');
#insert some values for events
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`) VALUES ('1', '1', 'womens 63', '1', '1', '2020-04-03 04:03:01', 'ATHLET');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`) VALUES ('2', '1', 'mens 69', '1', '1', '2020-04-03 04:03:01', 'ATHLET');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('4', '4', 'women basketball', '1', '1', '2020-04-03 04:03:01', 'TEAM', '1');
INSERT INTO event (`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('5', '4', 'women basketball', '2', '1', '2020-04-03 04:03:01', 'TEAM', '1');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('6', '4', 'women basketball', '2', '1', '2020-04-03 04:03:01', 'TEAM', '2');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('7', '4', 'women basketball', '3', '1', '2020-04-03 04:03:01', 'TEAM', '1');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('8', '4', 'women basketball', '3', '1', '2020-04-03 04:03:01', 'TEAM', '2');
INSERT INTO event (`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('9', '4', 'women basketball', '3', '1', '2020-04-03 04:03:01', 'TEAM', '3');
INSERT INTO event (`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`, `eventGroupe`) VALUES ('10', '4', 'women basketball', '3', '1', '2020-04-03 04:03:01', 'TEAM', '4');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`) VALUES ('11', '2', 'womens 200m sprint', '1', '1', '2020-04-03 04:03:01', 'ATHLET');
INSERT INTO event(`eventId`, `eventSportID`, `eventName`, `eventRank`, `eventVenueId`, `eventDateTimeStart`, `eventType`) VALUES ('12', '2', 'mens 200m sprint', '1', '1', '2020-04-03 04:03:01', 'ATHLET');

#insert some data for participance
INSERT INTO participance values(1,12,NULL,1,'1:02:03',1,NULL,true);
INSERT INTO participance values(2,12,NULL,2,'1:02:03',1,NULL,true);
INSERT INTO participance values(3,12,NULL,3,'1:02:03',1,NULL,true);
INSERT INTO participance values(4,12,NULL,4,'1:02:05',2,NULL,true);
INSERT INTO participance values(5,12,NULL,5,'1:02:00',3,NULL,true);
INSERT INTO participance values(6,11,NULL,22,'1:20:50',1,NULL,true);
INSERT INTO participance values(7,11,NULL,23,'1:20:55',2,NULL,true);
INSERT INTO participance values(8,11,NULL,24,'1:20:55',2,NULL,true);
INSERT INTO participance values(9,11,NULL,25,'1:20:59',3,NULL,true);
INSERT INTO participance values(10,11,NULL,26,'1:28:00',4,NULL,false);
INSERT INTO participance values(11,1,NULL,27,'300kg',1,NULL,true);
INSERT INTO participance values(12,1,NULL,28,'270kg',2,NULL,true);
INSERT INTO participance values(13,1,NULL,29,'267kg',3,NULL,true);
INSERT INTO participance values(14,1,NULL,30,'250kg',4,NULL,false);
INSERT INTO participance values(15,1,NULL,31,'200kg',5,NULL,false);
INSERT INTO participance values(16,2,NULL,10,'400kg',1,NULL,true);
INSERT INTO participance values(17,2,NULL,11,'390kg',2,NULL,true);
INSERT INTO participance values(18,2,NULL,12,'350kg',3,NULL,true);
INSERT INTO participance values(19,2,NULL,13,'330kg',4,NULL,false);
INSERT INTO participance values(20,4,4,NULL,'40/30',1,NULL,true);
INSERT INTO participance values(21,4,5,NULL,'40/20',2,NULL,true);
INSERT INTO participance values(22,5,4,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(23,5,6,NULL,'40/30',2,NULL,true);
INSERT INTO participance values(24,6,5,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(25,6,7,NULL,'40/30',2,NULL,false);
INSERT INTO participance values(26,7,4,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(28,7,3,NULL,'40/30',2,NULL,false);
INSERT INTO participance values(29,8,5,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(30,8,8,NULL,'40/30',2,NULL,false);
INSERT INTO participance values(31,9,6,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(32,9,9,NULL,'40/30',2,NULL,false);
INSERT INTO participance values(33,10,7,NULL,'40/30',1,NULL,false);
INSERT INTO participance values(34,10,10,NULL,'40/30',2,NULL,false);

# -----PROCEDURES AND FUNCTIONS---- #

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `countWins`(givenTeamId int) RETURNS int(11)
BEGIN
DECLARE wins int;
 SET wins =(SELECT COUNT(participanceId)
    FROM
        participance
    WHERE
       participanceRecordRank = 1 AND participanceTeamID = givenTeamId);
RETURN wins;
END$$
DELIMITER ;
DELIMITER $$

#returns the name of an athlet for the event name and the rank given
#e.g. who won the first place on 400m running
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getNameFromEventAndRankAthlet`(
  givenEventName varchar(100),
  givenRank int
) RETURNS varchar(400) CHARSET utf8
BEGIN
DECLARE name VARCHAR(400);
DECLARE tie VARCHAR (200);
DECLARE numberOfTies int;
declare i int;

	SET numberOfTies= (
		SELECT count(athletID)FROM athlet
		INNER JOIN participance
		ON participanceEventID = (SELECT eventId FROM event WHERE eventName=givenEventName)
		WHERE participanceAthlet = athletID
		AND participanceRecordRank = givenRank
	);

	 SET i=0; 
      WHILE i<=numberOfTies DO
       SET tie = (SELECT  concat( athletName , ' ', athletLastName ) 
			FROM athlet
		INNER JOIN participance
		ON participanceEventID = (SELECT eventId FROM event WHERE eventName=givenEventName)
		WHERE participanceAthlet = athletID
		AND participanceRecordRank = givenRank  limit 1 offset i);
        IF (name IS NOT NULL and tie IS NOT NULL) THEN
       SET name = concat(name,',',' ',tie);
       SET i=i+1;
       ELSE
       IF(tie IS NOT NULL) THEN
       SET name =tie;
       SET i=i+1;
       else
       SET i=i+1;
       END IF;
       END IF;
       
	END WHILE;
	
RETURN name;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `count_medals`(givenMedalRank int) RETURNS int(11)
BEGIN
DECLARE total_medals int;
DECLARE add_to_total_medals int;
DECLARE Max_overall_table_id int;
DECLARE Min_overall_table_id int;
DECLARE i int;
DECLARE participants_string varchar(300);

SET Max_overall_table_id = (SELECT Max(id) FROM overall_record_table);
SET Min_overall_table_id = (SELECT Min(id) FROM overall_record_table);
SET i=Min_overall_table_id;

#loop on the overall results table to count the times the rank we are looking for appears
WHILE i<=Max_overall_table_id DO

#check if the participant with that rank is a team
IF ((SELECT participanceRank FROM overall_record_table WHERE id=i)=givenMedalRank AND
(SELECT eventType FROM event WHERE eventName=
(SELECT eventName FROM overall_record_table WHERE id=i) limit 1) ='TEAM' )THEN

#if it is a team count all the members of the team since they all get medals
IF (total_medals IS NULL )THEN
 SET total_medals = (SELECT count(teamMemberAthletId) FROM team_member WHERE
 teamMemberTeamId = (SELECT teamID FROM team WHERE teamName=
 (SELECT participanceName FROM overall_record_table WHERE id=i)));
 else
  SET total_medals = total_medals + (SELECT count(teamMemberAthletId) FROM team_member WHERE
  teamMemberTeamId = (SELECT teamID FROM team WHERE teamName=
  (SELECT participanceName FROM overall_record_table WHERE id=i)));
  END IF;
  END IF;
  
 #check if its an athlet
 IF ((SELECT participanceRank FROM overall_record_table WHERE id=i)=givenMedalRank AND
(SELECT eventType FROM event WHERE eventName=
(SELECT eventName FROM overall_record_table WHERE id=i) limit 1) ='ATHLET')THEN

  SET participants_string = (SELECT participanceName FROM overall_record_table WHERE id=i);
  IF (total_medals IS NULL )THEN
  #if it is a tie count how many athlets where in the tie 
  #(more than one names are always separeted by ',')
  SET total_medals = (LENGTH(participants_string ) - LENGTH(REPLACE(participants_string, ',', ''))+1);
  else
  SET total_medals = total_medals + (LENGTH(participants_string ) - LENGTH(REPLACE(participants_string, ',', ''))+1);
  END IF;
  SET i=i+1;
  else
  SET i=i+1;
  END IF;
END WHILE;

RETURN total_medals;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_values_overall_record`()
BEGIN
DECLARE eventsNum int;
DECLARE i int;
DECLARE eventsName varchar(300);
DECLARE ranks int;
DECLARE name varchar(400);
DECLARE n int;
DECLARE l int;
DECLARE participances int;
DECLARE record varchar(45);
#counts all the events (number of events not their stages) throught their names
SET  eventsNum = (SELECT count(DISTINCT eventName) FROM event);
SET i=0;

#for each event
WHILE i<=eventsNum DO
#get the name
SET eventsName = (SELECT DISTINCT eventName FROM event limit 1 offset i);
#counts total amount of participants taking place
SET participances=(SELECT count(participanceId) FROM participance
INNER JOIN event
ON eventId= participanceEventID AND eventName=eventsName);

SET l=0;
#for each participance
WHILE l<=participances DO
SET ranks = participances-l;
SET n=ranks-1;
#if it is team event get the rank for each, from procedure teamRank
IF ((SELECT eventType FROM event WHERE eventName=eventsName limit 1)='TEAM')THEN
CALL teamRank(eventsName,3,2);
SET name = (SELECT teamName FROM team WHERE teamId=
(SELECT participanceTeamID FROM teamsorder  ORDER BY wins DESC LIMIT 1 OFFSET n));

SET record=(SELECT participanceRecord FROM participance WHERE participanceTeamID =
(SELECT teamID FROM team WHERE teamName = name limit 1) limit 1);
IF (name IS NOT NULL)THEN
INSERT INTO overall_record_table(eventName,participanceRank,participanceName, participanceRecord)
values(eventsName,ranks,name,record);

DROP TABLE if exists teamsorder; 
END IF;
SET l=l+1;
#if its individual event repeat the procedure using getNameFromEventAndRankAthlet
else
SET name =(SELECT getNameFromEventAndRankAthlet(eventsName,ranks));
SET record=(SELECT participanceRecord FROM participance WHERE participanceAthlet =
(SELECT athletID FROM athlet WHERE concat(athletName,' ', athletLastName) = name limit 1) );
IF (record IS NULL) THEN
 SET record=(SELECT participanceRecord FROM participance WHERE participanceAthlet =
(SELECT athletID FROM athlet WHERE concat(athletName,' ', athletLastName) = 
(SELECT LEFT(name,INSTR(name,",")-1))));
END IF;
IF (name IS NOT NULL)THEN
INSERT INTO overall_record_table(eventName,participanceRank,participanceName, participanceRecord)
values(eventsName,ranks,name,record);
END IF;
SET l=l+1;
END IF;
END WHILE;
SET i=i+1;
END WHILE;
END$$
DELIMITER ;

DELIMITER $$
#procedure that returns the teams name for an event name and a spesific rank 
CREATE DEFINER=`root`@`localhost` PROCEDURE `teamRank`(givenEventName varchar(100), givenRank int,perpuse int)
BEGIN
DECLARE n int;
DECLARE team int;
DECLARE Max int;
DECLARE Min int;
DECLARE i int;
SET n = givenRank-1;
DROP table IF exists teamsorder;
#create temprary table in order to order teams depending on how many wins they have 
CREATE temporary table`teamsorder` (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, 
participanceTeamID int, wins int); 

INSERT INTO teamsorder(participanceTeamID) SELECT DISTINCT participanceTeamID FROM participance
INNER JOIN event
ON eventId=participanceEventID AND eventName=givenEventName;

#for every teamId that took part in the event use function countWins to fill the colum
# wins of each with the teamsID with total amount of wins in the event
SET Max = (SELECT Max(id) FROM teamsorder);
SET Min=(SELECT Min(id) FROM teamsorder); 
SET i=Min;
WHILE i<=Max DO
SET team = (SELECT participanceTeamID FROM teamsorder WHERE id=i);
UPDATE teamsorder SET wins = (SELECT countWins(team ))
WHERE id =i;
SET i = i+1;
end while;
#if we are only needing one quiry for a specific rank
#it is executed through the function and then temporary table is droped
IF perpuse=1 THEN
SELECT teamRank(givenEventName,givenRank);
DROP table teamsorder;
#if we need to use the table more than once instead we drop 
#it after end of our quiry that makes use of this procedure
END IF;
END$$
DELIMITER ;
DELIMITER $$
#this procedure checks for an event name if its a team or individual
# one and returns the name of the team or athlet with the a sertain final rank
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `new_getResultFromRank`(givenEventName varchar(400),givenRank int)
BEGIN
IF (
	(
		SELECT eventType
		FROM event
		WHERE eventName=givenEventName
		limit 1
	) = 'ATHLET')
	 AND
	(#select events where the stage is final or have no stages for the final rank
		(SELECT eventRank
		FROM event
		WHERE eventName=givenEventName
	) = 1 OR
    (SELECT eventRank
		FROM event
		WHERE eventName=givenEventName
	) IS NULL)
THEN
SELECT getNameFromEventAndRankAthlet(givenEventName,givenRank);
 END IF;
 IF ((SELECT eventType FROM event WHERE eventName=givenEventName limit 1 ) = 'TEAM')THEN
 CALL teamRank(givenEventName,givenRank,1);
 END IF;
END$$
DELIMITER ;
DELIMITER $$
#function that executes the query for teamRank procedure
CREATE DEFINER=`root`@`localhost` FUNCTION `teamRank`(givenEventName varchar(100), givenRank int) 
RETURNS varchar(400) CHARSET utf8
BEGIN
DECLARE n int;

DECLARE name varchar(400);
SET n = givenRank-1;


SET name = (SELECT teamName FROM team WHERE teamId=
(SELECT participanceTeamID FROM teamsorder  ORDER BY wins DESC LIMIT 1 OFFSET n ));
RETURN name;
END$$
DELIMITER ;

#create view medals_and_numbers_of_participances_per_event
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` 
SQL SECURITY DEFINER VIEW `medals_and_numbers_of_participances_per_event` 
AS select `a`.`eventName` AS `name`,
count(distinct `a`.`id`) AS `numberOfParticipances`,
(select group_concat(`overall_record_table`.`participanceName` separator ',') 
from `overall_record_table`
 where ((`overall_record_table`.`eventName` = `a`.`eventName`)
 and (`overall_record_table`.`participanceRank` = 1))
 group by `overall_record_table`.`eventName`) AS `gold`,
 (select group_concat(`overall_record_table`.`participanceName` separator ',')
 from `overall_record_table`
 where ((`overall_record_table`.`eventName` = `a`.`eventName`) 
 and (`overall_record_table`.`participanceRank` = 2)) 
 group by `overall_record_table`.`eventName`) AS `silver`,
 (select group_concat(`overall_record_table`.`participanceName` separator ',') 
 from `overall_record_table`
 where ((`overall_record_table`.`eventName` = `a`.`eventName`)
 and (`overall_record_table`.`participanceRank` = 3)) 
 group by `overall_record_table`.`eventName`) AS `bronze` from `overall_record_table` `a`
 group by `a`.`eventName`;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_events_from_sports`(givenSportName varchar(100))
BEGIN
SELECT DISTINCT eventName FROM event WHERE eventSportID=
(SELECT sportsID FROM sports WHERE sportsName= givenSportName);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_event_results`(givenEventName varchar(40))
BEGIN
SELECT participanceName, participanceRecord, participanceRank FROM overall_record_table
WHERE eventName = givenEventName ORDER BY participanceRank;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stages`(givenEventName varchar(50))
BEGIN

SELECT event.eventRank, team.teamName, participance.participanceRecordRank, event.eventGroupe
FROM event
INNER JOIN participance
ON participance.participanceEventID = event.eventId
inner join team
on team.teamID=participance.participanceTeamID
where event.eventName= givenEventName ORDER BY event.eventRank,event.eventGroupe;


END$$
DELIMITER ;


CALL insert_values_overall_record();

