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

  def saveFromFlex(self, request, member):
    logging.debug(member)
    member.save()
    return member

  def remove(self, request, member):
    member.delete()
