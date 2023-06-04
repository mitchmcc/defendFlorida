#/bin/sh
#set -x

echo "select dataDate as 'Voter Roll Date'  from voterdbinfo" | sqlite3 votersdb

for i in 110915759 110915761 110915783 110915782 110915838 110915842 110915846 110915853 110915881 110915929 110915943 110915947 110915951 110915986 110916013 107213337 106754858 106811813 107328680 114852388 107437224 106758383 106908151 106873060 122366478 106974476 106856575 106704102 105237532
do
     sqlite3 votersdb "select voterId, firstName, lastName, birthDate, (strftime('%Y', 'now') - strftime('%Y', birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', birthDate)) as "Age" from voters where voterId = $i"
    echo "----------------------------------------------------------------------------------------------"
done
