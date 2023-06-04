#/bin/bash
#set -x

ID='114813356'

#echo ID=$ID

sqlite3 votersdb "select voterId, firstName, lastName from voters where voterId = ${ID}"

