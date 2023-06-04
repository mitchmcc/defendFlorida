-- voters > age
.print
.print "Voters over 100 that voted on 11/03/2020"
.print

SELECT A.voterId as "Voter Id",
       A.firstName as "First Name",
       A.lastName as "Last Name",
       A.birthDate as "DOB",
       (strftime('%Y', 'now') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate)) as "Age"
from voters as A JOIN voteHistory B on A.voterId = B.voterId
where age > 100 AND B.electionDate = '2020-11-03'
order by age desc;



