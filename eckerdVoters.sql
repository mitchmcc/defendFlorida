.width 10 12 12 15 20 20 20 10 20 10
.print "Eckerd College Active Voters list - 4200 54TH AVE S. ST PETERSBURG, FL"
.print
select voterId, firstName, lastName, birthDate, mailAddr1, mailAddr2, mailCity, mailState, mailCountry, mailZip from voters where resAddr1 = '4200   54TH AVE S' and voterStatus = 'ACT';
