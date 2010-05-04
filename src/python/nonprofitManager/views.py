from django.shortcuts import render_to_response
from nonprofitManager.models import Member, Section
from nonprofitManager.report import Report, Page, Info
from nonprofitManager.mongoModels import Award

from django import http
from django.template.loader import get_template
from django.template import Context
from django.db import connection

from settings import  MEDIA_ROOT 

import ho.pisa as pisa
import cStringIO as StringIO
import locale


def index(request, reportName):
  locale.setlocale(locale.LC_ALL, '') 
  query = Member.objects
  if request.GET.get('sortCol'):
    query = query.order_by('%s%s' % ('-' if request.GET.get('sortDir') == 'DESC' else '', request.GET.get('sortCol')))

  if request.REQUEST.getlist('pk[]'):
    query = query.filter(pk__in=request.REQUEST.getlist('pk[]')) 

  report = Report(
    Page(orientation='landscape', withCounterColumn=False), 
    Info(), 
    query.all(),
    request.REQUEST.getlist('col[]')
  )
  data = {'MEDIA_ROOT': MEDIA_ROOT, 'report': report}
  if request.REQUEST.get('method', 'pdf') == 'html':
      return render_to_response(report.page.template, data)
  else:
      return write_pdf(report.page.template, data)


def write_pdf(template_src, context_dict):
    html   = get_template(template_src).render(Context(context_dict))
    result = StringIO.StringIO()
    pdf    = pisa.pisaDocument(StringIO.StringIO(html.encode("UTF-8")), result)
    print connection.queries
    if not pdf.err:
      return http.HttpResponse(result.getvalue(), mimetype='application/pdf')
    else:
      return http.HttpResponse("Gremlin's ate your pdf! %s" % html)


def mongo(request):
  award = Award()
  items = award.getAll(None)
  print len(items)
  print type(items[0]._id)
  id = str(items[0]._id)
  print type(id)
  return http.HttpResponse(items[0]._id)
