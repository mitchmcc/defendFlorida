# get every election date and type

sqlite> select DISTINCT electionDate, electionType from voteHistory order by electionDate ASC;
electionDate  electionType
------------  ------------
2006/03/07    GEN         
2006/03/14    GEN         
2006/09/05    PRI         
2006/09/19    OTH         
2006/11/07    GEN         
2007/03/13    OTH         
2007/04/24    OTH         
2007/09/11    OTH         
2007/11/06    OTH         
2008/01/29    PPP         
2008/03/11    OTH         
2008/03/25    PRI         
2008/04/15    GEN         
2008/06/03    OTH         
2008/08/26    PRI         
2008/11/04    GEN         
2009/03/10    OTH         
2009/09/01    OTH         
2009/11/03    OTH         
2010/03/09    OTH         
2010/08/24    PRI         
2010/11/02    GEN         
2011/03/08    OTH         
2011/04/19    OTH         
2011/08/30    OTH         
2011/11/08    OTH         
2012/01/31    PPP         
2012/03/13    OTH         
2012/08/14    PRI         
2012/11/06    GEN         
2013/03/12    OTH         
2013/08/27    OTH         
2013/11/05    OTH         
2014/01/14    PRI         
2014/03/11    GEN         
2014/08/26    PRI         
2014/11/04    GEN         
2015/03/10    OTH         
2015/04/21    GEN         
2015/08/25    OTH         
2015/11/03    OTH         
2016/03/15    PPP         
2016/08/30    PRI         
2016/11/08    GEN         
2017/03/14    OTH         
2017/05/02    OTH         
2017/08/01    OTH         
2017/08/29    OTH         
2017/11/07    OTH         
2018/03/13    OTH         
2018/04/17    OTH         
2018/08/28    PRI         
2018/11/06    GEN         
2019/03/12    OTH         
2019/08/27    OTH         
2019/11/05    OTH         
2020/03/17    PPP         
2020/08/18    PRI         
2020/11/03    GEN         
2021/03/09    OTH         
2021/08/24    OTH         
2021/11/02    OTH

# get only GEN and PRI



sqlite> select DISTINCT electionDate, electionType from voteHistory where electionType in ('GEN','PRI') order by electionDate ASC;
electionDate  electionType
------------  ------------
2006/03/07    GEN         
2006/03/14    GEN         
2006/09/05    PRI         
2006/11/07    GEN         
2008/03/25    PRI         
2008/04/15    GEN         
2008/08/26    PRI         
2008/11/04    GEN         
2010/08/24    PRI         
2010/11/02    GEN         
2012/08/14    PRI         
2012/11/06    GEN         
2014/01/14    PRI         
2014/03/11    GEN         
2014/08/26    PRI         
2014/11/04    GEN         
2015/04/21    GEN         
2016/08/30    PRI         
2016/11/08    GEN         
2018/08/28    PRI         
2018/11/06    GEN         
2020/08/18    PRI         
2020/11/03    GEN





select A.voterId, A.firstName, A.lastName, A.birthDate, A.gender, A.regDate, A.party
 	from voters as A JOIN voteHistory as B ON A.voterId = B.voterId 
 	where A.voterStatus = 'ACT' and
	(select electionDate from voteHistory where electionDate = '2018/03/13') AND
	(select electionDate from voteHistory where electionDate = '2018/03/13') AND
	(select electionDate from voteHistory where electionDate = '2018/04/17') AND
	(select electionDate from voteHistory where electionDate = '2018/08/28') AND
	(select electionDate from voteHistory where electionDate = '2018/11/06') AND
	(select electionDate from voteHistory where electionDate = '2019/03/12') AND
	(select electionDate from voteHistory where electionDate = '2019/08/27') AND
	(select electionDate from voteHistory where electionDate = '2019/11/05') AND
	(select electionDate from voteHistory where electionDate = '2020/03/17') AND
	(select electionDate from voteHistory where electionDate = '2020/08/18') AND
	(select electionDate from voteHistory where electionDate = '2020/11/03') AND
	(select electionDate from voteHistory where electionDate = '2021/03/09') AND
	(select electionDate from voteHistory where electionDate = '2021/08/24') AND
	(select electionDate from voteHistory where electionDate = '2021/11/02')
	limit 25;
	
	
 select A.voterId, A.firstName, A.lastName, A.birthDate, A.gender, A.regDate, A.party, B.electionDate
 	from voters as A JOIN voteHistory as B ON A.voterId = B.voterId 
 	where A.voterStatus = 'ACT' and
	B.electionDate = '2018/03/13' or
	B.electionDate = '2018/03/13' or
	B.electionDate = '2018/04/17' or
	B.electionDate = '2018/08/28' or
	B.electionDate = '2018/11/06' or
	B.electionDate = '2019/03/12' or
	B.electionDate = '2019/08/27' or
	B.electionDate = '2019/11/05' or
	B.electionDate = '2020/03/17' or
	B.electionDate = '2020/08/18' or
	B.electionDate = '2020/11/03' or
	B.electionDate = '2021/03/09' or
	B.electionDate = '2021/08/24' or
	B.electionDate = '2021/11/02' group by B.voterId;
	
	
	
# from Sqlite forum - doesn't work
SELECT DISTINCT(lastName), voterId FROM voters NATURAL JOIN votehistory 
WHERE electionDate IN (
	'2020/11/03',
	'2020/03/13',
	'2020/03/17',
	'2019/08/27'
	)
GROUP BY voterId
HAVING COUNT(*)==4;


#2

select voterID,firstName,lastName,resCity,precinct
  from voters
 where voterid in (
     select voterID
     from votehistory
     WHERE electionDate IN (
	'2020/08/18','2020/11/03','2021/03/09','2021/08/24','2021/11/02')
      group by voterID having count(*) == 5
      )
;

# 2A
select voterID,firstName,lastName,resCity,precinct
  from voters
 where voterid in (
     select voterID
     from votehistory
     WHERE electionType in ('GEN', 'PRI', 'OTH') and electionDate IN (
     '2016/03/15',
     '2016/08/30',
     '2016/11/08',
     '2017/03/14',
     '2017/05/02',
     '2017/08/01',
     '2017/08/29',
     '2017/11/07',
     '2018/03/13',
     '2018/04/17',
     '2018/08/28',
     '2018/11/06',
     '2019/03/12',
     '2019/08/27',
     '2019/11/05',
     '2020/03/17',
     '2020/08/18',
     '2020/11/03',
     '2021/03/09',
     '2021/08/24',
     '2021/11/02'
     )
      group by voterID having count(*) == 21
      )
;

# 2B - only GEN and PRI but all 23

select voterID,firstName,lastName,resCity,precinct
  from voters
 where voterid in (
     select voterID
     from votehistory
     WHERE electionType in ('GEN', 'PRI') and electionDate IN (
     '2006/03/07',
     '2006/03/14',
     '2006/09/05',
     '2006/11/07',
     '2008/03/25',
     '2008/04/15',
     '2008/08/26',
     '2008/11/04',
     '2010/08/24',
     '2010/11/02',
     '2012/08/14',
     '2012/11/06',
     '2014/01/14',
     '2014/03/11',
     '2014/08/26',
     '2014/11/04',
     '2015/04/21',
     '2016/08/30',
     '2016/11/08',
     '2018/08/28',
     '2018/11/06',
     '2020/08/18',
     '2020/11/03'
     )
      group by voterID having count(*) == 23
      )
;

#2C fewer dates and only active REP - NO HITS

select voterID,firstName,lastName,resCity,precinct
  from voters
 where precinct = 309 and voterStatus = 'ACT' and party = 'REP' and voterid in (
     select voterID
     from votehistory
     WHERE electionType in ('GEN', 'PRI') and electionDate IN (
     '2008/03/25',
     '2008/04/15',
     '2008/08/26',
     '2008/11/04',
     '2010/08/24',
     '2010/11/02',
     '2012/08/14',
     '2012/11/06',
     '2014/01/14',
     '2014/03/11',
     '2014/08/26',
     '2014/11/04',
     '2015/04/21',
     '2016/08/30',
     '2016/11/08',
     '2018/08/28',
     '2018/11/06',
     '2020/08/18',
     '2020/11/03'
     )
      group by voterID having count(*) == 19
      )
;

#2D fewer dates and only active REP 

select voterID,firstName,lastName,resCity,precinct, regDate
  from voters
 where precinct = 309 and voterStatus = 'ACT' and party = 'REP' and voterid in (
     select voterID
     from votehistory
     WHERE electionType in ('GEN', 'PRI') and electionDate IN (
     '2012/08/14',
     '2012/11/06',
     '2014/01/14',
     '2014/03/11',
     '2014/08/26',
     '2014/11/04',
     '2015/04/21',
     '2016/08/30',
     '2016/11/08',
     '2018/08/28',
     '2018/11/06',
     '2020/08/18',
     '2020/11/03'
     )
      group by voterID having count(*) == 13
      )
;

#2E fewer dates and only active REP 

select voterID,gender, birthDate, firstName,lastName,resAddr1, resAddr2, resCity, resZip
  from voters
 where precinct = 309 and voterStatus = 'ACT' and party = 'REP' and voterid in (
     select voterID
     from votehistory
     WHERE electionDate IN ('2020/11/03')
      group by voterID having count(*) == 1
      )
;


# all elections with type

sqlite> select distinct electionDate, electionType from voteHistory order by electionDate limit 100;
electionDate  electionType
------------  ------------
2006/03/07    GEN         
2006/03/14    GEN         
2006/09/05    PRI         
2006/09/19    OTH         
2006/11/07    GEN         
2007/03/13    OTH         
2007/04/24    OTH         
2007/09/11    OTH         
2007/11/06    OTH         
2008/01/29    PPP         
2008/03/11    OTH         
2008/03/25    PRI         
2008/04/15    GEN         
2008/06/03    OTH         
2008/08/26    PRI         
2008/11/04    GEN         
2009/03/10    OTH         
2009/09/01    OTH         
2009/11/03    OTH         
2010/03/09    OTH         
2010/08/24    PRI         
2010/11/02    GEN         
2011/03/08    OTH         
2011/04/19    OTH         
2011/08/30    OTH         
2011/11/08    OTH         
2012/01/31    PPP         
2012/03/13    OTH         
2012/08/14    PRI         
2012/11/06    GEN         
2013/03/12    OTH         
2013/08/27    OTH         
2013/11/05    OTH         
2014/01/14    PRI         
2014/03/11    GEN         
2014/08/26    PRI         
2014/11/04    GEN         
2015/03/10    OTH         
2015/04/21    GEN         
2015/08/25    OTH         
2015/11/03    OTH         
2016/03/15    PPP         
2016/08/30    PRI         
2016/11/08    GEN         
2017/03/14    OTH         
2017/05/02    OTH         
2017/08/01    OTH         
2017/08/29    OTH         
2017/11/07    OTH         
2018/03/13    OTH         
2018/04/17    OTH         
2018/08/28    PRI         
2018/11/06    GEN         
2019/03/12    OTH         
2019/08/27    OTH         
2019/11/05    OTH         
2020/03/17    PPP         
2020/08/18    PRI         
2020/11/03    GEN         
2021/03/09    OTH         
2021/08/24    OTH         
2021/11/02    OTH     


# find out who voted the most

select voterId, count() from voteHistory group by voterId order by count();

# most prolific voters in 309 who are ACT and REP

select B.voterId, count(), A.gender, A.birthDate, A.firstName, A.lastName,  A.resAddr1, A.resAddr2, A.resCity, A.resZip from voteHistory as B join voters as A on A.voterId = B.voterId where A.precinct = 309 and A.voterStatus = 'ACT' and A.party = 'REP'  group by B.voterId order by count() DESC;


# same but voterIds only
select B.voterId from voteHistory as B join voters as A on A.voterId = B.voterId where A.precinct = 309 and A.voterStatus = 'ACT' and A.party = 'REP' group by B.voterId order by count();

# finally only prolific voters who also voted on Nov 03, 2020
select B.voterId, count(), A.gender, A.birthDate, A.firstName, A.lastName,  A.resAddr1, A.resAddr2, A.resCity, A.resZip 
from voteHistory as B join voters as A on A.voterId = B.voterId 
where A.resCity = 'ST PETERSBURG' 
group by A.voterId order by count() ASC
;


# for Ryan
select B.voterId, count(), A.firstName, A.lastName, A.gender, A.resAddr1, A.resAddr2, A.resCity, A.resZip from voteHistory as B join voters as A on A.voterId = B.voterId where A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT' group by B.voterId order by count();


# save!!!
select B.voterId, A.firstName, A.lastName from voteHistory as B join voters as A where A.voterId = B.voterId and electionDate = '2020/11/03' and B.voterId in (select B.voterId from voteHistory as B join voters as A on A.voterId = B.voterId where A.precinct = 309 and A.voterStatus = 'ACT' and A.party = 'REP');

# works
select B.voterId, A.firstName, A.lastName from voteHistory as B join voters as A where A.voterId = B.voterId and electionDate = '2020/11/03' and B.voterId in (select B.voterId from voteHistory as B join voters as A on A.voterId = B.voterId where A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT');

# same as above but only returns voterId
select B.voterId from voteHistory as B join voters as A where A.voterId = B.voterId and electionDate = '2020/11/03' and B.voterId in (select B.voterId from voteHistory as B join voters as A on A.voterId = B.voterId where A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT');

# change = to < --- appears to work but returns all not just one
select B.voterId, B.electionDate, A.firstName, A.lastName from voteHistory as B join voters as A where A.voterId = B.voterId and electionDate < '2020/11/03' and B.voterId in (select B.voterId from voteHistory as B join voters as A on A.voterId = B.voterId where A.resCity = 'ST PETERSBURG' and A.voterStatus = 'ACT') order by B.voterId, B.electionDate;






