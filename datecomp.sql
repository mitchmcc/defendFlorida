-- get the most recent two dates

SELECT PD.latest, PD.prev
  FROM (
    SELECT LD.latest, (SELECT MAX(concertDate) FROM concerts WHERE concertDate < LD.latest) AS prev
      FROM (SELECT MAX(concertDate) AS latest FROM concerts) AS LD
  ) AS PD
 ;
 

-- diff between 2 dates

julianday('now', 'localtime') - julianday(DateCreated)


select id, artist, concertDate, julianday('now', 'localtime') - julianday(concertDate) as "Julian date" from concerts order by concertDate asc;
id          artist      concertDate  Julian date
----------  ----------  -----------  -----------
102         ELO         1998-04-18   2450921.5  
103         YES         2003-11-02   2452945.5  
101         JOE COCKER  2007-03-22   2454181.5  
100         FOO FIGHTE  2019-03-22   2458564.5  
sqlite> 


Select id, artist, concertDate, Cast ((
    JulianDay('now') - JulianDay(concertDate)
) As Integer) from concerts order by concertDate asc;

-- get most recent one
Select id, artist, concertDate, Cast ((
    JulianDay('now') - JulianDay(concertDate)
) As Integer) from concerts order by concertDate desc limit 1;

-- get latest one before that one

Select id, artist, concertDate, Cast ((
    JulianDay('now') - JulianDay(concertDate)
) As Integer) from concerts where concertDate < (Select concertDate from concerts order by concertDate desc limit 1)
order by concertDate desc limit 1;


-- votehistory
select voterId, electionDate from votehistory where voterId = '114813356' order by electionDate asc;

select electionDate, 
Cast ((
    JulianDay('2020-11-03') - JulianDay(electionDate)
) As Integer) as "diff"
from votehistory
where voterId = '114813356'
and electionDate < '2020-11-03'
and diff > 70
order by electionDate desc limit 10;

-- now look at more voters
select A.voterId, A.firstName, A.lastName, A.birthDate, B.electionDate, 
       (strftime('%Y', 'now') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate)) as "Age",
Cast ((
    JulianDay('2020-11-03') - JulianDay(electionDate)
) As Integer) as "diff"
from voters as A join votehistory as B on A.voterId = B.voterId
where B.electionDate < '2020-11-03'
and diff > (365 * 4)
and age > 90
order by electionDate desc limit 20;


