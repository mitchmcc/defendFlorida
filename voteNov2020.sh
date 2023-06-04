#/bin/sh
#set -x

if [ "$#" -eq 0 ] 
then
    echo "Usage:  voteNov2020.sh [voterId]"
    exit 0
fi

voterId=$1

echo "VoterId Nov 2020 Election Query"
echo
echo "select dataDate as 'Voter Roll Date'  from voterdbinfo" | sqlite3 votersdb
echo

#echo "select A.voterId, A.firstName, A.lastName, A.resAddr1, A.resCity, A.voterStatus
#from voters as A JOIN voteHistory as B ON A.voterId = B.voterId
#where B.electionDate = '2020-11-03' and A.voterId = '$voterId';" | sqlite3 votersdb 

echo "select count()
from voters as A JOIN voteHistory as B ON A.voterId = B.voterId
where B.electionDate = '2020-11-03' and A.voterId = '$voterId';" | sqlite3 -line votersdb 

