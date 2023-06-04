.echo off

-- pared down versions because voterId is known; different report sections for each part

.mode line

.print
.print
.print "Voter Report for Voter ID: 999999999"
.print "------------------------------------"
.print

select dataDate as "Voter Roll Date"  from voterdbinfo;
.print

select
	voterId as "Voter ID",
	firstName as "First Name",
	middleName as "Middle Name",
	lastName as "Last Name",
	birthDate as "DOB",
	regDate as "Registration Date",
	gender as "Gender",
	county as "County",
CASE race
     WHEN '1' THEN 'American Indian or Alaskan Native'
     WHEN '2' THEN 'Asian or Pacific Islander'
     WHEN '3' THEN 'Black, Not Hispanic'
     WHEN '4' THEN 'Hispanic'
     WHEN '5' THEN 'White, Not Hispanic'
     WHEN '6' THEN 'Other'
     WHEN '7' THEN 'Multi-racial'
     WHEN '8' THEN 'Unknown'
     ELSE 'ERROR: UNKNOWN CODE'
END as "Race",
    party as "Party",
CASE voterStatus
     WHEN 'ACT' THEN 'Active'
     WHEN 'INA' THEN 'Inactive'
     ELSE 'ERROR: UNKNOWN CODE'
END as "Status"
from voters where voterId='999999999';

.print
.print "Residential Address"
.print

-- address part
select resAddr1 as "Address Line 1", resAddr2 as "Address Line 2", resCity as "City", resZip as "Zip Code"
from voters where voterId='999999999';

.print
.print "Mailing Address"
.print

select mailAddr1 as "Mailing Address Line 1",
mailAddr2 as "Mailing Address Line 2",
mailAddr3 as "Mailing Address 3",
mailCity as "Mailing City",
mailState as "Mailing State",
mailZip as "Mailing Zip Code",
mailCountry as "Country"
from voters where voterId='999999999';

.print
.print "Vote History (most recent first)"
.print

select electionDate as "Election Date",
electionType as "Election Type",
CASE historyCode
	WHEN 'A' THEN 'Mail'
	WHEN 'B' THEN 'Mail Ballot Not Counted'
	WHEN 'E' THEN 'Early'
	WHEN 'N' THEN 'Did not vote'
	WHEN 'P' THEN 'Provisional'
	WHEN 'Y' THEN 'Voted at polls'
	ELSE 'ERROR: UNKNOWN CODE'
END as "History Code"
from votehistory where voterId = '999999999'
ORDER BY electionDate DESC;
