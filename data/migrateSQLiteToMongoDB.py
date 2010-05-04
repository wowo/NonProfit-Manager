#!/usr/bin/python

import sqlite3
import pymongo

print
print "====================================="
print "Migrating data from sqlite to mongodb"
print "====================================="
print

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d
connection = sqlite3.connect('db.sqlite')
connection.row_factory = dict_factory

cursor = connection.cursor()
cursor.execute("SELECT * FROM members_member")

mongoConnection = pymongo.Connection()
db = mongoConnection.nonprofit
if db.members.count() > 0:
  print "Already imported, quiting."
else:
  for row in cursor.fetchall():
    row['functions'] = map(lambda x: x.strip(), row['functions'].split(','))
    del row['id']
    db.members.insert(row)
  print "Imported %d members." % db.members.count()
