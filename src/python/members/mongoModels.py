# -*- coding: utf-8 -*-
from pymongo import Connection

class mongoModel:
  def populate(self, dict):
    for key in dict:
      self.__dict__[key] = dict[key]

  def getDb(self):
    con = Connection()
    return con.nonprofit

class Award(mongoModel):
  def getAll(self, request):
    results = []
    for document in self.getDb().awards.find():
      award = Award()
      award.populate(document)
      results.append(award)
    print 'Awards %d' % len(results)
    return results

  def __str__(self):
    return str(self.__dict__)
    
