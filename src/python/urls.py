from django.conf.urls.defaults import *
from members import gateway
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
  (r'^admin/', include(admin.site.urls)),
  (r'^gateway/$', gateway.echoGateway),
  (r'^crossdomain.xml$', 'django.views.static.serve', {'document_root': 'static', 'path': 'crossdomain.xml'}),
  (r'^$', 'django.views.static.serve', {'document_root': '../flex/bin-debug/', 'path': 'nonProfitManager.html'}),
  (r'^(?P<path>.*)$', 'django.views.static.serve', {'document_root': '../flex/bin-debug/'}),
)
