CREATE TABLE voters (
    voterId integer PRIMARY key,
    county TEXT NOT NULL,
    lastName TEXT NOT NULL,
    nameSuffix TEXT,
    firstName TEXT NOT NULL,
    middleName TEXT,
    pubRecExempt TEXT,
    resAddr1 TEXT NOT NULL,
    resAddr2 TEXT,
    resCity TEXT NOT NULL,
    resState TEXT NOT NULL,
    resZip TEXT NOT NULL,
    mailAddr1 TEXT,
    mailAddr2 TEXT,
    mailAddr3 TEXT,
    mailCity TEXT,
    mailState TEXT,
    mailZip TEXT,
    mailCountry TEXT,
    gender TEXT,
    race TEXT,
    birthDate DATE,
    regDate DATE,
    party TEXT,
    precinct TEXT,
    precinctGroup TEXT,
    precinctSplit TEXT,
    precinctSuffix TEXT,
    voterStatus TEXT,
    congDistrict TEXT,
    houseDistrict TEXT,
    senateDistrict TEXT,
    countyDistrict TEXT,
    schoolDistrict TEXT,
    daytimeAreacode TEXT,
    daytimePhone TEXT,
    daytimePhoneExt TEXT,
    emailAddress TEXT

);