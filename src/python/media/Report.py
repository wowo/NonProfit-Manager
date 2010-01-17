from datetime import datetime

class Report:
  page = None
  info = None

  def __init__(page, info):
    self.page = page
    self.info = info

class Page:
  orientation = 'portrait'
  margin = '1cm'

  def __init__(self, orientation, margin):
    if orientation:
      self.orientation = orientation
    if margin:
      self.margin = margin

class Info:
  creator = 'Wojciech Sznapka'
  createdAt = None
  dateFormat = '%d %B %Y, %H:%M'

  def __init__(self, creator, createdAt, dateFormat):
    if creator:
      self.creator = creator
    if dateFormat:
      self.dateFormat = dateFormat
    if createdAt:
      self.createdAt = createdAt
    else:
      self.createdAt = datetime.strftime(datetime.now(), self.dateFormat) 
