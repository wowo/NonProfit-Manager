from django.shortcuts import render_to_response
from members.models import Member, Section
from members.report import Report, Page, Info

from django import http
from django.template.loader import get_template
from django.template import Context
from settings import  MEDIA_ROOT 

import ho.pisa as pisa
import cStringIO as StringIO
import locale


def index(request, reportName):
  members = Member.objects.all()
  locale.setlocale(locale.LC_ALL, '') 
  return write_pdf('memberList.html',{
      'pagesize' : 'A4',
      'objects': members,
      'MEDIA_ROOT':MEDIA_ROOT,})


def write_pdf(template_src, context_dict):
    context_dict['report'] = Report(Page(orientation='landscape'), Info())
    #return render_to_response('memberList.html', Context(context_dict))

    html = get_template(template_src).render(Context(context_dict))
    result = StringIO.StringIO()
    pdf  = pisa.pisaDocument(StringIO.StringIO(html.encode("UTF-8")), result)
    if not pdf.err:
      return http.HttpResponse(result.getvalue(), mimetype='application/pdf')
    else:
      return http.HttpResponse("Gremlin's ate your pdf! %s" % html)
