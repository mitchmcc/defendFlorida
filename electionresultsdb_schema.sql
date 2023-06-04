CREATE TABLE electionresults (
       electionDate	  DATE NOT NULL,
       partyCode	  CHAR(3),
       partyName	  TEXT,
       raceCode		  CHAR(3),
       raceName		  TEXT,
       countyCode	  CHAR(3),
       countyName	  TEXT,
       juris1Num	  CHAR(3),
       juris2Num	  CHAR(3),
       precincts	  INTEGER,
       precinctsReporting INTEGER,
       candNameLast	  TEXT,
       candNameFirst	  TEXT,
       candNameMiddle	  TEXT,
       candVotes	  INTEGER
 );
       
