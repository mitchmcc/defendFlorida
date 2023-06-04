-- now look at more voters
.print
.print "Voters over 85 who voted on 11/03/2020"
.print

select A.voterId, A.firstName, A.lastName, A.birthDate, B.electionDate, B.historyCode,
       (strftime('%Y', 'now') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate)) as "Age",
Cast ((
    JulianDay('2020-11-03') - JulianDay(electionDate)
) As Integer) as "diff"
from voters as A join votehistory as B on A.voterId = B.voterId
where B.electionDate < '2020-11-03'
and diff > (1)
and age > 85
and B.electionDate > '2016-01-01'
order by age desc, B.electionDate desc limit 50;
