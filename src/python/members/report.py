from datetime import datetime

"""
  Report class, containing many informations about it
  It aggregates page and info objects
"""
class Report:
  page = None
  info = None
  """
    Constructor
  """
  def __init__(self, page, info):
    self.page = page
    self.info = info


"""
  Report page informations (orientation, margins, size)
"""
class Page:
  orientation = 'portrait'
  margin = '1cm'
  size = 'a4'
  """
    Constructor
  """
  def __init__(self, orientation=None, margin=None, size=None):
    if orientation:
      self.orientation = orientation
    if margin:
      self.margin = margin
    if size:
      self.size = size


"""
  Informations about report (creator, date, signature etc)
"""
class Info:
  creator = 'Wojciech Sznapka'
  createdAt = None
  dateFormat = '%d %B %Y, %H:%M'
  signature = "Wygenerowano przy pomocy programu Non Profit Manager"
  """
    Constructor
  """
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
