#/bin/sh
#set -x

if [ "$#" -eq 0 ] 
then
    echo "Usage:  oneVoter.sh [voterId]"
    exit 0
fi

voterId=$1
#echo "Vote history for voterId $i"

cat voterReportTemplate.sql | sed "s/999999999/$voterId/g" | sqlite3 votersdb 
