from datetime import datetime

class Report:
  page = None
  info = None
  def __init__(self, page, info):
    self.page = page
    self.info = info

class Page:
  orientation = 'portrait'
  margin = '1cm'
  size = 'a4'
  def __init__(self, orientation=None, margin=None, size=None):
    if orientation:
      self.orientation = orientation
    if margin:
      self.margin = margin
    if size:
      self.size = size

class Info:
  creator = 'Wojciech Sznapka'
  createdAt = None
  dateFormat = '%d %B %Y, %H:%M'
  def __init__(self, creator=None, createdAt=None, dateFormat=None):
    if creator:
      print "creator %s" % creator

      self.creator = creator
    if dateFormat:
      self.dateFormat = dateFormat
    if createdAt:
      self.createdAt = createdAt
    else:
      self.createdAt = datetime.strftime(datetime.now(), self.dateFormat) 
