
import os
import csv
import sys
import pdb
import re
import string
import getopt
import time
import datetime
import logging
import sqlite3
import dateutil
from dateutil.relativedelta import relativedelta

version = "01.00.00"

def usage():
  print("oneVoter.py Version %s, Usage:" % (version))
  print("  -f  Database file name")
  print("  -I  Voter ID (overrides first and last name if present)")
  print("  -d  Enable debug")
  print("  -v  Enable verbose")
  print("  -h  This help message")




# set up database stuff

databaseName = "/home/mitchmcc/Documents/src/python/votersdb2020"
debug = False
verbose = False
voterId = None
yearsGap = 4
csvOutput = True

try:
    opts, args = getopt.getopt(sys.argv[1:], "f:I:y:dvh", ["help", "output="])
except getopt.GetoptError as err:
    # print(help information and exit:
    print(str(err)) # will printsomething like "option -a not recognized"
    usage()
    sys.exit(2)

for o, a in opts:
    if o == "-f":
        databaseName = a
        if debug == 1:
            print("Got databaseName from command line: ",databaseName)
    elif o == "-I":
        voterId = a
        if debug == 1:
            print("Got voterId from command line: ",voterId)
    elif o == "-y":
        yearsGap = int(a)
        if debug == 1:
            print("Got years gap from command line: ", yearsGap)
    elif o == "-d":
        debug = 1
        if debug == 1:
            print("Set debug from command line")
    elif o == "-v":
        verbose = 1
        if debug == 1:
            print("Set verbose from command line")
    elif o == "-h":
        usage()
        sys.exit(2)
    else:
        print("ERROR: unhandled option: ",o)
        usage()
        sys.exit(2)

if voterId is None:
    print("ERROR: must provide voterId")
    sys.exit(1)

if debug:
    print("VoterId = %s" % (voterId))

numElections = 0
totalSuspect = 0

firstName = ""
lastName = ""
resAddr1 = ""
resAddr2 = ""
resCity = ""
resZip = ""
birthDate = ""
regDate = ""
vote2020Type = ""
party = ""
precinct = ""

voteHist = {
    "A" : "Voted by mail",
    "B" : "Vote-by-mail ballot not counted",
    "E" : "Voted early",
    "N" : "Did not vote",
    "P" : "Provisional ballot not counted",
    "Y" : "Voted at polls"
    }

# see if file exists

if not os.path.isfile(databaseName):
    logging.error("ERROR: file " + databaseName + " not found")
    sys.exit(4)

conn = sqlite3.connect(databaseName)
cursor = conn.cursor()

if verbose:
   print("\nVoter ID: " + str(voterId))      
   
queryString = 'SELECT voterId, electionDate, historyCode FROM voteHistory WHERE voterId=\'' + str(voterId) + '\'' \
                  ' and electionDate <= "2020/11/03" order by electionDate DESC limit 2;'

if debug:
    print("Looking for vote history, SQL: " + queryString);

try:
    cursor.execute(queryString)
except sqlite3.OperationalError as oe:
    print("ERROR: SELECT failed - OperationalError")
    print("\tSQL: " + queryString)
    print(oe)
except Exception as othere:
    print("ERROR: SELECT failed - other exception")
    print(othere)

rows = cursor.fetchall()

numElections = 0

for row in rows:
    if debug:
        print("VoteHist row: " + str(row))

    numElections += 1
    priorElectionDate = row[1]           # this should be the 2020/11/03 election
    
    electionDate = row[1]           # this should be the 2020/11/03 election

    if numElections == 1:
        if verbose:
            print("\tElection Date: %s" % (row[1]))
    
        if row[1] != '2020/11/03':
            if verbose:
                print("\tDid not vote in Nov 2020")
            #pdb.set_trace()
            break
	       
        vote2020Type = str(row[2])

    if numElections == 2:

        if verbose:
            print("\tPrior Election Date: %s" % (row[1]))

        novDate = datetime.datetime.strptime('2020/11/03', "%Y/%m/%d")
        nextDate = datetime.datetime.strptime(priorElectionDate, "%Y/%m/%d")
	
        if debug:
            print("Nov2020: " + str(novDate))
            print("Next: " + str(nextDate))
	    
        difference_in_years = relativedelta(novDate, nextDate).years
	
        if verbose:
            print("\tDiff in years: " + str(difference_in_years))

        #pdb.set_trace()
	
        if difference_in_years >= yearsGap:
            print("\n\tFound suspect voter, vote history gap: " + str(yearsGap) + " years")

            #pdb.set_trace()
	 
            # Now get voter info

            queryString = 'SELECT voterId, firstName, lastName, birthDate, regDate, resAddr1, resAddr2, resCity, resZip, voterStatus, party,precinct		        FROM voters WHERE voterId=' + str(voterId) + ';'

            try:
                cursor.execute(queryString)
            except sqlite3.OperationalError as oe:
                print("ERROR: insert failed - OperationalError")
                print(oe)
            except Exception as othere:
                print("ERROR: insert failed - other exception")
                print(othere)

            rows = cursor.fetchall()

            for row in rows:

                if debug:
                    print("Voter row: " + str(row))
    		
                if verbose:
                    print("\tVoterId: %s, First name: %s, Last name: %s, BirthDate: %s" % (row[0], row[1], row[2], row[3]))
    
                firstName = str(row[1])
                lastName  = str(row[2])
                birthDate = str(row[3])
                regDate = str(row[4])
                resAddr1 = str(row[5])
                resAddr2 = str(row[6])
                resCity = str(row[7])
                resZip = str(row[8])
                regStatus = str(row[9])
                party = str(row[10])
                precinct = str(row[11])
        
                print("\tBirth Date: " + birthDate)
                print("\t2020 Vote: " + voteHist.get(vote2020Type))
                print("\tStatus: " + regStatus)
                print("\tParty: " + party)
                print("\tPrecinct: " + precinct)
                print("\tName: " + firstName + " " + lastName)
                print("\tAddress1: " + resAddr1)
                print("\tAddress2: " + resAddr2)
                print("\tCity: " + resCity)
                print("\tZip: " + resZip)
                print("\tRegistration Date: " + regDate)
                totalSuspect += 1

                if csvOutput:
                    print("\tCSV: " + voterId + "," + 
                    birthDate + "," +
                    voteHist.get(vote2020Type)  + "," +
                    regStatus  + "," +
                    party  + "," +
                    precinct + "," +		    
                    firstName + " " + lastName  + "," +
                    resAddr1  + "," +
                    resAddr2  + "," +
                    resCity  + "," +
                    resZip  + "," +
                    regDate)
                    		
                break
	    
conn.commit()
conn.close()

if debug:
    print("\nTotal suspect voters: %d" % (totalSuspect))

sys.exit(totalSuspect)


