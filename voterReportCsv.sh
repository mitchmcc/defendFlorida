#!/bin/sh
#set -x

if [ "$#" -eq 0 ] 
then
    echo "Usage:  voterReportsFile.sh [file]"
    exit 0
fi

#echo "File: $1"

if [ -f "$1" ] # checking if file exist
then 

    while read line
 do
     voterId=`echo "$line" | awk '{print $1}'`
     export voterId
     
     #echo "Voter ID: $voterId"
     
     echo "Select voterId, firstName, middleName, lastName, birthDate, resAddr1, resAddr2, resCity, resZip from voters where voterId = ${voterId};" | sqlite3 -noheader -csv votersdb2020
     
 done <"$1" # double quotes important to prevent word splitting
else
  echo "Sorry file $1 doesn't exist"
fi
