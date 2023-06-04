#----------------------------------------------------------------------------------------------
#
#  loadflhistory.py
#
#----------------------------------------------------------------------------------------------
#
#          Date		Version		Who		Description
#
#	02/12/2022	01.00.01	mjm		Fixed date format to YYYY/MM/DD
#
#----------------------------------------------------------------------------------------------

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

voteHist = {
    "A" : "Voted by mail",
    "B" : "Vote-by-mail ballot not counted",
    "E" : "Voted early",
    "N" : "Did not vote",
    "P" : "Provisional ballot not counted",
    "Y" : "Voted at polls"
    }


# set up database stuff

dataDate = "20220712"

databaseName = os.getcwd() + "/votersdb_" + dataDate
inputFileName = "/home/mitch/Documents/DefendFlorida/flvoters/" + dataDate + "/PIN_H_" + dataDate + ".txt"

debug = False
verbose = True
totalRecords = 0

# see if file exists

if not os.path.isfile(databaseName):
    logging.error("ERROR: file " + databaseName + " not found")
    sys.exit(4)

conn = sqlite3.connect(databaseName)
     
if debug:
    pdb.set_trace()

with open(inputFileName, mode='r') as file:
        csvFile = csv.reader(file,delimiter='\t')
	
	# displaying the contents of the CSV file
        for lines in csvFile:
            #print(lines)
            #print("type: " + str(type(lines)))
            if debug:
                pdb.set_trace()
            
            #fields = lines[0].split('\t')
            fields = lines

            county = fields[0]
            voterId = int(fields[1])
            if debug:
                print("County : %s, VoterId : %d" % (county, voterId))

            if fields[2] != "":
                parts = fields[2].split('/')
                electionDate = parts[2] + '/' + parts[0] + '/' + parts[1]
            else:
                electionDate = None	    

            electionType = fields[3]
            historyCode = fields[4]

            if verbose:
                print("Voter ID: %s County: %s Election Date: %s Election Type: %s, HistoryCode: %s" % (voterId,county, electionDate,electionType,historyCode))
            
            insertData = (voterId, county, electionDate, electionType, historyCode);

            if debug:
                pdb.set_trace()

            insertSql = ''' INSERT INTO votehistory (voterId, county, electionDate, electionType, historyCode) \
                    VALUES (?, ?, ?, ?, ?) '''
 
            cur = conn.cursor()

            try:
                cur.execute(insertSql, insertData)    
                conn.commit()

                if verbose:
                    print("%-8d - Voter ID: %s Date: %s" % (totalRecords, voterId, electionDate))

                totalRecords += 1
		
            except sqlite3.IntegrityError as oe:
                dupFound = True
                # we know we can get duplicates, but we don't consider that a real error
                if debug:
                    print("WARNING: insert failed - IntegrityError, key: %s" % (voterId))
                pass
            except sqlite3.OperationalError as oe:
                print("ERROR: insert failed - OperationalError")
                print(oe)
            except othere:
                print("ERROR: insert failed - other exception")
                print(othere)

print("Total records: %d" % (totalRecords))
