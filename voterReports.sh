#/bin/sh
#set -x

echo "select dataDate as 'Voter Roll Date'  from voterdbinfo" | sqlite3 votersdb

#echo "select voterId, firstName, lastName from voters where voterId='106974476'" | sqlite3 votersdb

for i in 105237532 106692360 106704102 106754858 106758383 106759678 106810202 106811813 106856575 106873060 106908151 106974476 107213337 107328680 107361843 107437224 114852388 122366478
do
    echo "Vote history for voterId $i"
    cat voterReportTemplate.sql | sed "s/999999999/$i/g" | sqlite3 votersdb 
    echo "----------------------------------------------------------------------------------------------"
    echo "\n\n"
done
