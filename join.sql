select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity from voters as A JOIN voteHistory as B ON A.voterId = B.voterId limit 10;



 select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, 
 	B.electionDate, B.electionType, B.historyCode 
 	from voters as A JOIN voteHistory as B ON A.voterId = B.voterId 
 	where A.voterId = '114813356';



select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, B.electionDate, B.electionType, B.historyCode from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where B.electionDate = '08/18/2020' limit 20;
voterId     firstName   lastName    resAddr1              resCity     electionDate  electionType  historyCode
----------  ----------  ----------  --------------------  ----------  ------------  ------------  -----------
100002076   RONALD      CARLSON     11485   OAKHURST RD   LARGO       08/18/2020    PRI           A          
100023829   ALLAN       BECK        974   ALCAZAR WAY S   ST PETERSB  08/18/2020    PRI           A     

# MJM
sqlite> select * from voteHistory where voterId = '114813356';
voterId     county      electionDate  electionType  historyCode
----------  ----------  ------------  ------------  -----------
114813356   PIN         11/04/2014    GEN           A 

# LEM         
sqlite> select * from voteHistory where voterId = '114813364';
voterId     county      electionDate  electionType  historyCode
----------  ----------  ------------  ------------  -----------
114813364   PIN         08/18/2020    PRI           A          


select voterId, count(*) from voteHistory group by voterId having count(*)>2;


select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, 
  B.electionDate, B.electionType, B.historyCode 
  from voters as A JOIN voteHistory as B ON A.voterId = B.voterId 
  where electionDate = '2020/11/03' limit 10;

# add on precinct

# get distinct addresses of all voters who voted on 11/03/2020

select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, 
  B.electionDate, B.electionType, B.historyCode 
  from voters as A JOIN voteHistory as B ON A.voterId = B.voterId 
  where electionDate = '11/03/2020' and A.resAddr2 is not NULL limit 10;


# count of distinct addresses where there is no apt/unit number

#select resAddr1, count() from voters where resAddr2 is not NULL group by resAddr1;

select resAddr1, resAddr2, resCity, count(resAddr1) 
      from voters where resAddr2 is NULL group by resAddr1 order by count(resAddr1) DESC;


# single voter did they vote on Nov 30 2020?

select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, B.electionDate, B.electionType, B.historyCode
from voters as A JOIN voteHistory as B ON A.voterId = B.voterId
where B.electionDate = '2020-11-03' and A.voterId = '100294795';

select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where B.electionDate = '2020-11-03' and A.voterId = '107006724';


# SHOULD RETURN
select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
(select B.electionDate from voteHistory where B.voterId = '107006724' and B.electionDate = '2020/11/03') limit 1;

# SHOULD NOT RETURN
select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
(select B.electionDate from voteHistory where B.voterId = '106759284' and B.electionDate = '2020/11/03') limit 1;


select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
A.resAddr1 = '7101   ML KING ST N' and A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT'  and
(select B.electionDate from voteHistory where B.electionDate = '2020/11/03');

select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
A.resAddr1 = '7501   38TH AVE N' and A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT'  and
(select B.electionDate from voteHistory where B.electionDate = '2020/11/03');

select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
A.resAddr1 = '3456   21ST AVE S' and A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT'  and
(select B.electionDate from voteHistory where B.electionDate = '2020/11/03');


select A.voterId, A.firstName, A.lastName from voters as A JOIN voteHistory as B ON A.voterId = B.voterId where
A.resAddr1 = '1095   PINELLAS POINT DR S' and A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT'  and
(select B.electionDate from voteHistory where B.electionDate = '2020/11/03');



# Nested subquery to try and get 11/03/2020 and one prior

select A.voterId, A.firstName, A.lastName, B.electionDate from voters as A join voteHistory as B on A.voterId = B.voterId where B.electionDate = '2020/11/03' or (select B.electionDate from voteHistory where B.electionDate < '2020/11/03') order by A.voterId, B.electionDate DESC limit 30;


(strftime('%Y', electionDate') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate))

select voterId, electionDate, strftime('%Y', electionDate') - LAG(strftime('%Y', electionDate'), 1) OVER (ORDER BY voterId) as DateDiff from voteHistory where voterId = '100012113';

select voterId, birthDate, strftime('%Y', birthDate') - LAG(strftime('%Y', birthDate'), 1) OVER (ORDER BY birthDate) from voters where voterId = '100012113';

julianday(concertDate) -  lag(julianday(concertDate),1) over (order by concertDate rows between 1 preceding and 1 preceding) as DeltaDays


select voterId, electionDate, electionDate - LAG(electionDate, 1) OVER (ORDER BY voterId) as DateDiff from voteHistory where voterId = '100012113';

