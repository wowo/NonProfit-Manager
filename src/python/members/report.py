from datetime import datetime
from django.db.models.fields import FieldDoesNotExist

"""
  Report class, containing many informations about it
  It aggregates page and info objects
"""
class Report:
  data = None
  info = None
  page = None
  """
    Constructor
  """
  def __init__(self, page, info, objects, columns):
    self.page = page
    self.info = info
    self.data = DataProvider(objects, columns, page.withCounterColumn)


"""
  Report page informations (orientation, margins, size)
"""
class Page:
  margin = '1cm'
  orientation = 'portrait'
  size = 'a4'
  template = 'reportList.html'
  withCounterColumn = True
  """
    Constructor
  """
  def __init__(self, orientation=None, margin=None, size=None, withCounterColumn=True, template=None):
    self.withCounterColumn = withCounterColumn
    if orientation:
      self.orientation = orientation
    if margin:
      self.margin = margin
    if size:
      self.size = size
    if template:
      self.template = template


"""
  Informations about report (creator, date, signature etc)
"""
class Info:
  createdAt = None
  creator = 'Wojciech Sznapka'
  dateFormat = '%d %B %Y, %H:%M'
  institution = 'OSP Woszczyce'
  signature = 'Wygenerowano przy pomocy programu Non Profit Manager'
  """
    Constructor
  """
  def __init__(self, creator=None, createdAt=None, dateFormat=None, institution=None):
    if creator:
      self.creator = creator
    if institution:
      self.institution = institution
    if dateFormat:
      self.dateFormat = dateFormat
    if createdAt:
      self.createdAt = createdAt
    else:
      self.createdAt = datetime.strftime(datetime.now(), self.dateFormat) 


"""
  Provides data (table rows) for report. It convert it from model objects.
"""
class DataProvider:
  columns = []
  labels  = []
  rows    = []
  columnsCount = 0
  """
    Constructor
  """
  def __init__(self, objects, columns, withCounterColumn):
    self.columns = columns
    self.labels = self.getLabelsFromModel(columns, objects[0])
    self.rows   = self.convert(objects, columns)
    self.columnsCount = len(columns) + (1 if withCounterColumn else 0)


  def convert(self, objects, columns):
    result = []
    for object in objects:
      tmp = []
      for column in columns:
        value = getattr(object, column)
        value = value if value else ''
        tmp.append((column, value))
      result.append(tmp)
    return result

  def getLabelsFromModel(self, columns, object):
    result = []
    for column in columns:
      try:
        verboseName = object._meta.get_field(column).verbose_name
      except FieldDoesNotExist:
        verboseName = column
      result.append(verboseName.capitalize())
    return result
