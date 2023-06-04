#/bin/sh
#set -x

# Convert to upper case

echo "select dataDate as 'Voter Roll Date'  from voterdbinfo" | sqlite3 votersdb

first=$(echo $1 | tr '[:lower:]' '[:upper:]')
last=$(echo $2 | tr '[:lower:]' '[:upper:]')

sqlite3 votersdb "select voterId, firstName, lastName, resCity, birthDate, (strftime('%Y', 'now') - strftime('%Y', birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', birthDate)) as "Age" from voters where firstName='$first' and lastName='$last'"
