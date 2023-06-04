#----------------------------------------------------------------------------------------------
#
#  loadflvoters.py
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

raceCodes = {
    "1" : "American Indian or Alaskan Native",
    "2" : "Asian or Pacific Islander",
    "3" : "Black not hispanic",
    "4" : "Hispanic",
    "5" : "White, not hispanic",
    "6" : "Other",
    "7" : "Multi-racial",
    "8" : "Unknown"
    }

politicalParties = {
    "CPF" : "Constitution Party",
    "DEM" : "Democratic Party",
    "ECO" : "Ecology Party",
    "GRE" : "Green Party",
    "IND" : "Independent Party",
    "LPF" : "Libertarian Party",
    "NPA" : "No Party Affiliation",
    "PSL" : "Party for socialism",
    "PEO" : "People's Party",
    "REF" : "Reform Party",
    "REP" : "Republican Party",
    "UPF" : "Unity Party"
    }

# set up database stuff

# NOTE: the date listed for the file does not match the download file name, so
# for now I am going to use the more conservative of the two..

dataDate = "20220712"

databaseName = os.getcwd() + "/votersdb_" + dataDate
inputFileName = "/home/mitch/Documents/DefendFlorida/flvoters/" + dataDate + "/PIN_" + dataDate + ".txt"

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
            lastName = fields[2]
            nameSuffix = fields[3]
            firstName = fields[4]
            middleName = fields[5]
            
            pubRecExempt = fields[6]
            resAddr1 = fields[7]
            resAddr2 = fields[8]
            resCity = fields[9]
            resState = fields[10]
            resZip = fields[11]

            if debug:
                print("Address1: %s" % (resAddr1))
                print("Address2: %s" % (resAddr2))
                print("City: %s" % (resCity))
                print("State: %s" % (resState))
            
            mailAddr1 = fields[12]
            mailAddr2 = fields[13]
            mailAddr3 = fields[14]
            mailCity = fields[15]
            mailState = fields[16]
            mailZip = fields[17]
            mailCountry = fields[18]
            gender = fields[19]
            race = fields[20]

            #print("Birthdate: %s" % (fields[21]))
                
            if fields[21] != "" and fields[21] != '*':
                parts = fields[21].split('/')
                birthDate = parts[2] + '/' + parts[0] + '/' + parts[1]
            else:
                birthDate = None	    
	    
            regDate = fields[22]
            party = fields[23]

            if debug:
                print("Party: %s" % (politicalParties[party]))
                  
            precinct = fields[24]
            precinctGroup = fields[25]
            precinctSplit = fields[26]
            precinctSuffix = fields[27]
            voterStatus = fields[28]
            congDistrict = fields[29]
            houseDistrict = fields[30]
            senateDistrict = fields[31]
            countyDistrict = fields[32]
            schoolDistrict = fields[33]
            daytimeAreacode = fields[34]
            daytimePhone = fields[35]
            daytimePhoneExt = fields[36]
            emailAddress = fields[37]

            if verbose:
                print("%-8d - Voter ID: %s Name: %s %s %s, Email: %s" % (totalRecords, voterId,firstName, middleName, lastName,emailAddress))
            
            insertData = (voterId, county, lastName, nameSuffix, firstName, middleName, pubRecExempt, resAddr1,
                resAddr2, resCity,resState,resZip,mailAddr1,mailAddr2,mailAddr3,mailCity,mailState,mailZip,mailCountry,
                gender,race,birthDate,regDate,party,precinct,precinctGroup,precinctSplit,precinctSuffix,voterStatus,
                congDistrict,houseDistrict,senateDistrict,schoolDistrict,countyDistrict,daytimeAreacode,daytimePhone,
                daytimePhoneExt,emailAddress);

            if debug:
                pdb.set_trace()

            insertSql = ''' INSERT INTO voters (voterId, county, lastName, nameSuffix, firstName, middleName, pubRecExempt, resAddr1,
                resAddr2, resCity,resState,resZip,mailAddr1,mailAddr2,mailAddr3,mailCity,mailState,mailZip,mailCountry,
                gender,race,birthDate,regDate,party,precinct,precinctGroup,precinctSplit,precinctSuffix,voterStatus,
                congDistrict,houseDistrict,senateDistrict,schoolDistrict,countyDistrict,daytimeAreacode,daytimePhone,
                daytimePhoneExt,emailAddress) \
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
                    ?, ?, ?, ?, ?, ?, ?, ?) '''
 
            cur = conn.cursor()

            try:
                cur.execute(insertSql, insertData)    
                conn.commit()
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
