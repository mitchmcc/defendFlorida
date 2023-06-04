#!/usr/bin/python
#------------------------------------------------------------------------------------------------
#
#   pcsocalls.py
#
#   Version        Date         Who     Description
#
#   01.00.00      12/26/2021    mjm     Fixed wildcard bug
#
# Supervised offender search:
#
#http://www.dc.state.fl.us/OffenderSearch/list.aspx?Page=List&TypeSearch=AO&DataAction=Filter&dcnumber=&LastName=Aaron&FirstName=Blake&SearchAliases=1&OffenseCategory=&photosonly=0&nophotos=1&matches=20
#
#------------------------------------------------------------------------------------------------

from bs4 import BeautifulSoup
from bs4 import Tag, NavigableString
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from datetime import datetime
#from urllib.request import urlopen
import urllib.request
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
import signal
 
def usage():
  logging.info("Usage:")
  logging.info("  -f  First name")
  logging.info("  -l  Last name")
  logging.info("  -d  Enable debug")
  logging.info("  -v  Enable verbose")
  logging.info("  -h  logging.info(this help message")

version = "01.00.00"

dumpTable = 0
debug = False
verbose = False
firstName = None
lastName = None

# set up logging the way we want it
logging.basicConfig(format='%(asctime)s %(message)s',level=logging.INFO)

if verbose == 1:
  logging.info("PCSOCalls version %s starting up",version)

try:
    opts, args = getopt.getopt(sys.argv[1:], "f:l:dvh", ["help", "output="])
except getopt.GetoptError as err:
    # logging.info(help information and exit:
    logging.info(str(err)) # will logging.infosomething like "option -a not recognized"
    usage()
    sys.exit(2)

for o, a in opts:
    if o == "-v":
        verbose = 1
        if debug:
            logging.info("Set verbose from command line")
    elif o == "-f":
         firstName = a
         if debug:
             logging.info("Set firstName from command line")
    elif o == "-l":
         lastName = a
         if debug:
             logging.info("Set lastName from command line")
    elif o == "-d":
        debug = 1
        logging.info("Set debug from command line")
    elif o == "-h":
        usage()
        sys.exit(2)
    else:
        logging.info("ERROR: unhandled option: ",o)
        usage()
        sys.exit(2)

if firstName == None and lastName == None:
   logging.error("ERROR: first and last names required")
   sys.exit(1)

if verbose:
    print("Checking %s %s" % (firstName, lastName))
    
#urlstring = "http://www.dc.state.fl.us/OffenderSearch/list.aspx?Page=List&TypeSearch=AO&DataAction=Filter&dcnumber=&" + lastName + "=Aaron&FirstName=" + firstName + "&SearchAliases=1&OffenseCategory=&photosonly=0&nophotos=1&matches=20"

urlstring = "http://www.dc.state.fl.us/OffenderSearch/list.aspx?Page=List&TypeSearch=AO&DataAction=Filter&dcnumber=&LastName=" + \
          lastName + "&FirstName=" + firstName + \
          "&SearchAliases=1&OffenseCategory=&photosonly=0&nophotos=1&matches=20"

page = urllib.request.urlopen(urlstring)
soup = BeautifulSoup(page, 'html.parser')

tab = soup.find("table")
    
if debug:
    pdb.set_trace()

if tab == None:
    if verbose:
        print("Name: %s %s not found" % (firstName, lastName))
    sys.exit(0)
    
for htmlrow in tab.find_all('tr'):
    col = htmlrow.find_all('td')
        
    if debug:
        print("col: ")
        print(col)
                
    count = 0

    for data in col:
        count = count + 1
        if debug:
            print("data: %d" % (count))
            print(data)

        if count == 1:
            name = col[1].find('a').contents[0].replace(' ','')
            print("Name: %s" % (name))

        if count == 2:
            Id = col[2].text
            print("Id: %s" % (Id))
            
        if count == 7:
            birthDate = col[7].text
            print("Birth Date: %s" % (birthDate))
            
        if debug:
            pdb.set_trace()
        
        spanList = data.find_all('span')

