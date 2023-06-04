.mode column
.echo off

.print
.print
.print "Out of State Active Voter Report"
.print "------------------------------------"
.print

select voterId, firstName, lastName, birthDate, voterStatus, mailAddr1, mailAddr2, mailCity, mailState, mailZip, mailCountry from voters where length(mailState) != 0 and mailState != '*' and voterStatus = 'ACT' and mailState != 'FL' order by mailState;

