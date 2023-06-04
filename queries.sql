select firstName, lastName, resAddr1, party from voters where resAddr1 like '%BOCA CIEGA ISLE%';

select firstName, lastName, resAddr1, resCity from voters where party = 'REP' and race = 3 and resCity like '%PETE BEACH%';

select count() from voters where party = 'REP' and race = 5;

select voterId, firstName, lastName, gender, party, birthDate from voters where party = 'REP' and resZip = '33706'


