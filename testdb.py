#!/usr/bin/python
#------------------------------------------------------------------------------------------------
#
#   testdb.py
#
#   Version        Date     Who     Description
#
#   01.00.00      02/13/22  mjm     Original version
#
#------------------------------------------------------------------------------------------------

from datetime import datetime
import os
import sys
import pdb
import time
import datetime
import sqlite3

databaseName = "testdb"

# artists
artists = [
    (1, "Jethro Tull"),
    (2, "ELP"),
    (3, "Yes"),
    (4, "Pat Metheny"),
    (3, "Leo Kottke")               # Dup for test
]

# songs
songs = [
      (100, "Thick as a Brick", 1),
      (101, "Tarkus", 2),
      (102, "Aqualung", 1),
      (103, "Close to the Edge", 3),
      (104, "First Circle", 4)
]

# see if file exists

if not os.path.isfile(databaseName):
    print("ERROR: file " + databaseName + " not found")
    sys.exit(4)

conn = sqlite3.connect(databaseName)

for artist in artists:

    #pdb.set_trace()
    insertData = (artist[0], artist[1])
    insertSql = ''' INSERT INTO artist (id, name) VALUES (?, ?) '''

    cur = conn.cursor()

    try:
        cur.execute(insertSql, insertData)
        conn.commit()
    except sqlite3.IntegrityError as oe:
       print("WARNING: insert failed - IntegrityError: data: " + str(insertData))

       updateSql = '''UPDATE artist set name = ? where id = ?'''
       updateData = (artist[1], artist[0])
       cur.execute(updateSql, updateData)
       conn.commit()
       pass
    except sqlite3.OperationalError as oe:
       print("ERROR: insert failed - OperationalError")
       print(oe)
    except Exception as e:
       print("ERROR: insert failed - other exception")
       print(e)
