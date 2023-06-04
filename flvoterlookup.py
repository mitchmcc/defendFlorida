
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

version = "01.00.00"

def usage():
  print("flvoterlookup.py Version %s, Usage:" % (version))
  print("  -f  Database file name")
  print("  -I  Voter ID (overrides first and last name if present)")
  print("  -g  First name (given name")
  print("  -s  Last name (surname)")
  print("  -e  Exact match (for first and last name, default: Off")
  print("  -d  Enable debug")
  print("  -v  Enable verbose")
  print("  -h  This help message")




# set up database stuff

databaseName = "/home/mitchmcc/Documents/src/python/votersdb"
inputFileName = "/home/mitchmcc/Documents/DefendFlorida/flvoters/PIN_20211012.txt"
debug = False
verbose = True
exact = False
voterId = None
firstName = None
lastName = None


try:
    opts, args = getopt.getopt(sys.argv[1:], "f:I:g:s:dveh", ["help", "output="])
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
    elif o == "-g":
        firstName = a
        if debug == 1:
            print("Got firstName from command line: ",firstName)
    elif o == "-s":
        lastName = a
        if debug == 1:
            print("Got lastName from command line: ",lastName)
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

if voterId is None and firstName is None and lastName is None:
    print("ERROR: must provide either voterId or first and last name")
    sys.exit(1)

if firstName is not None:
    firstName = firstName.upper()
if lastName is not None:
    lastName = lastName.upper()

if voterId is None:
    if firstName is not None and lastName is None:
        print("ERROR: must provide both first and last name")
        sys.exit(0)
    if lastName is not None and firstName is None:
        print("ERROR: must provide both first and last name")
        sys.exit(0)

if debug:
    print("VoterId = %s" % (voterId))
    print("First name = %s" % (firstName))
    print("Last name = %s" % (lastName))

# see if file exists

if not os.path.isfile(databaseName):
    logging.error("ERROR: file " + databaseName + " not found")
    sys.exit(4)

conn = sqlite3.connect(databaseName)
cursor = conn.cursor()

#if debug:
#    pdb.set_trace()

if voterId is not None:
    queryString = 'SELECT voterId, firstName, lastName, party FROM voters WHERE voterId=' + str(voterId) + ';'

    try:
        cursor.execute(queryString)
    except sqlite3.OperationalError as oe:
        print("ERROR: insert failed - OperationalError")
        print(oe)
    except othere:
        print("ERROR: insert failed - other exception")
        print(othere)

    rows = cursor.fetchall()
 
    for row in rows:
        if debug:
            print(row)
        print("VoterId: %s, First name: %s, Last name: %s, Party: %s" % (row[0], row[1], row[2], row[3]))

else:
    if debug:
        pdb.set_trace()

    names = (firstName,lastName)

    try:
        cursor.execute('SELECT voterId, firstName, lastName, party FROM voters WHERE firstName=? AND lastName=?', names)
    except sqlite3.OperationalError as oe:
        print("ERROR: insert failed - OperationalError")
        print(oe)
    except othere:
        print("ERROR: insert failed - other exception")
        print(othere)

    rows = cursor.fetchall()
 
    for row in rows:
        #pdb.set_trace()
        if debug:
            print(row)
        print("VoterId: %s, First name: %s, Last name: %s, Party: %s" % (row[0], row[1], row[2], row[3]))

conn.commit()
conn.close()
