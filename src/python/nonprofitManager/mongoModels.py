# -*- coding: utf-8 -*-
import logging
import pymongo
from pymongo import Connection

class mongoModel:
  def populate(self, dict):
    for key in dict:
      self.__dict__[key] = dict[key]
    self.__dict__['_id'] = unicode(self.__dict__['_id'])

  def getMongoDict(self):
    dict = self.__dict__
    dict['_id'] = pymongo.objectid.ObjectId(dict['_id'])
    return dict

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
    

class Member(mongoModel):
  def yearsOfService(self):
    return date.today().year - self.accessionDate.year
  yearsOfService.short_description = 'Lata służby'

  def getAll(self, request):
    results = []
    for document in self.getDb().members.find():
      member = Member()
      member.populate(document)
      results.append(member)
    print 'Members %d' % len(results)
    return results

  def saveObject(self):
    self.getDb().members.update({'_id':  pymongo.objectid.ObjectId(self._id)}, self.getMongoDict())

  def save(self, request, member):
    member.saveObject()
    return member

  def remove(self, request, member):
    member.delete()
