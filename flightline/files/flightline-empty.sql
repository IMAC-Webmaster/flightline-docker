PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

drop table IF EXISTS figure;
drop table IF EXISTS score;
drop table IF EXISTS sheet;
drop table IF EXISTS flight;
drop table IF EXISTS round;
drop table IF EXISTS state;
drop table IF EXISTS schedule;
drop table IF EXISTS nextFlight;
drop table IF EXISTS pilot;
drop table IF EXISTS user;

CREATE TABLE user
(
   userId         varchar not null primary key,
   fullName       varchar not null,
   password       varchar not null,
   address        varchar not null,
   roles	  varchar not null
);
CREATE TABLE schedule (
   schedId        varchar(8) not null primary key,
   imacClass      varchar(15),
   imacType       varchar(15) CHECK( imacType IN ('Known','Unknown','Freestyle') ) NOT NULL DEFAULT 'Known',
   description    varchar(64) not null
);
CREATE TABLE "figure" (
	`figureNum`	tinyint NOT NULL,
	`schedId`	varchar ( 8 ),
	`shortDesc`	varchar ( 20 ) NOT NULL,
	`longDesc`	varchar ( 128 ),
	`spokenText`	TEXT,
	`rule`	tinyint NOT NULL DEFAULT 1,
	`k`	tinyint NOT NULL,
	PRIMARY KEY(`figureNum`,`schedId`)
);
CREATE TABLE "state" (
	`key`	TEXT NOT NULL,
	`value`	TEXT,
	PRIMARY KEY(`key`)
);
CREATE TABLE "pilot" (
	`pilotId`	integer NOT NULL,
	`primaryId`	integer NOT NULL,
	`secondaryId`	integer,
	`fullName`	varchar ( 60 ) NOT NULL,
	`airplane`	varchar ( 60 ),
	`freestyle`	tinyint NOT NULL DEFAULT 0 CHECK(freestyle IN ( 0 , 1 )),
	`imacClass`	varchar ( 15 ) NOT NULL,
	`in_customclass1`	tinyint NOT NULL DEFAULT 0 CHECK(in_customclass1 IN ( 0 , 1 )),
	`in_customclass2`	tinyint NOT NULL DEFAULT 0 CHECK(in_customclass2 IN ( 0 , 1 )),
	`active`	active NOT NULL DEFAULT 1 CHECK(active IN ( 0 , 1 )),
	PRIMARY KEY(`pilotId`)
);
CREATE TABLE `flight` (
	`flightId`	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	`noteFlightId`	integer NOT NULL,
	`roundId`	integer NOT NULL,
	`sequenceNum`	integer NOT NULL,
	CONSTRAINT `flightid_round` UNIQUE(`noteFlightId`,`roundId`),
	CONSTRAINT `roundid_seq` UNIQUE(`roundId`,`sequenceNum`)
);
CREATE TABLE "round" (
	`roundId`	integer,
	`flightLine`	tinyint,
	`imacClass`	varchar ( 15 ) NOT NULL,
	`imacType`	varchar ( 15 ) NOT NULL DEFAULT 'Known' CHECK(imacType IN ( 'Known' , 'Unknown' , 'Freestyle' )),
	`roundNum`	number tinyint NOT NULL,
	`compRoundNum`	number tinyint,
	`schedId`	varchar ( 8 ) NOT NULL,
	`sequences`	tinyint NOT NULL,
	`phase`	text NOT NULL DEFAULT 'U' CHECK(phase IN ( 'U' , 'O' , 'P' , 'D' )),
	`status`	text DEFAULT null,
	`startTime`	integer,
	`finishTime`	integer,
	PRIMARY KEY(`roundId`),
	FOREIGN KEY(`schedId`) REFERENCES `schedule`(`schedId`),
	UNIQUE(`imacClass`,`imacType`,`roundNum`)
);
CREATE TABLE "nextFlight" (
	`nextNoteFlightId`	integer NOT NULL,
	`nextCompId`	integer NOT NULL,
	`nextPilotId`	integer NOT NULL,
	FOREIGN KEY(`nextPilotId`) REFERENCES `pilot`(`pilotId`),
	PRIMARY KEY(`nextNoteFlightId`,`nextCompId`,`nextPilotId`)
);
CREATE TABLE `score` (
	`sheetId`	integer NOT NULL,
	`figureNum`	tinyint NOT NULL,
	`scoreTime`	integer NOT NULL,
	`breakFlag`	tinyint NOT NULL DEFAULT 0 CHECK(breakFlag IN ( 0 , 1 )),
	`score`	numeric,
	`comment`	text,
	PRIMARY KEY(`sheetId`,`figureNum`),
	FOREIGN KEY(`sheetId`) REFERENCES `sheet`(`sheetId`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE "sheet" (
  `sheetId`        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  `roundId`        integer NOT NULL,
  `flightId`       integer NOT NULL,
  `pilotId`        integer NOT NULL,
  `judgeNum`       tinyint NOT NULL,
  `judgeName`      text DEFAULT null,
  `scribeName`     text DEFAULT null,
  `comment`        text DEFAULT null,
  `mppFlag`        tinyint NOT NULL DEFAULT 0 CHECK(mppFlag IN ( 0 , 1 )),
  `flightZeroed`   tinyint NOT NULL DEFAULT 0 CHECK(flightZeroed IN ( 0 , 1 )),
  `zeroReason`     text DEFAULT null,
  `phase`          text NOT NULL DEFAULT 'U' CHECK(phase IN ( 'U' , 'S' , 'D' )),
  UNIQUE(`flightId`,`roundId`,`pilotId`,`judgeNum`),
  FOREIGN KEY(`pilotId`) REFERENCES `pilot`(`pilotId`),
  FOREIGN KEY(`flightId`) REFERENCES `flight`(`flightId`),
  FOREIGN KEY(`roundId`) REFERENCES `round`(`roundId`)
);

INSERT INTO "state" VALUES('flightLineId','1');
INSERT INTO "state" VALUES('flightLineName','Default');
INSERT INTO "state" VALUES('flightLineUrl','http://flightline1.lan/data.php');

COMMIT;
