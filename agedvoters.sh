#/bin/sh
#set -x

echo "select dataDate as 'Voter Roll Date'  from voterdbinfo" | sqlite3 votersdb
    
for i in 106847146 116137529 106715662 106825469 106946491 106695279 106712518 106752589 106805290 106781142 103142283 106930393 106711402 106872006 106879518 107182737 121619688 106863028 106752016 104452494 106838761 106685794 106687219 106780845 119359996 106542218 106758584 106690779 106783138 106812817
do
    echo "Vote history for voterId $i"
    sqlite3 votersdb "select A.voterId, A.firstName, A.lastName, A.birthDate, (strftime('%Y', 'now') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate)) as "Age", B.electionDate from voters as A JOIN votehistory B on A.voterId = B.voterId  where A.voterId = $i order by B.electionDate desc limit 5"
    echo "----------------------------------------------------------------------------------------------"
done


