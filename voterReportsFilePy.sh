#!/bin/sh
#set -x

if [ "$#" -eq 0 ] 
then
    echo "Usage:  voterReportsFile.sh [file]"
    exit 0
fi

#echo "File: $1"
count=0
numFound=0
yearGap=8

DB=~/Documents/src/python/votersdb20210131
#DB=~/Documents/src/python/voterstestdb

echo "Suspect Voter Report"
echo "Voters who voted NOV 2020 but more than $yearGap years before"
echo "Run on: `date`"
echo -n "Voter DB date: "
echo "select dataDate from voterdbinfo;" | sqlite3 -noheader $DB

if [ -f "$1" ] # checking if file exist
then 
 while read line
 do
     voterId=`echo "$line" | awk '{print $1}'`
     export voterId
     
     #echo "Voter ID: $voterId"
     
     python3 ~/Documents/src/python/oneVoter.py -I ${voterId} -y $yearGap -f $DB  -v 

     numFound=$?

     count=`expr $count + $numFound `

     #echo "Returned: $numFound, count: $count"
     
 done <"$1" # double quotes important to prevent word splitting
else
  echo "Sorry file $1 doesn't exist"
fi

echo "Total suspected voters: $count"

