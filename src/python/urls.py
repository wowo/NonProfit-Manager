from django.conf.urls.defaults import *
from members import gateway

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
  (r'^admin/', include(admin.site.urls)),
  ('^gateway/$', gateway.echoGateway),
  ('^crossdomain.xml$', 'django.views.static.serve', {'document_root': 'static', 'path': 'crossdomain.xml'}),
  ('^$', 'django.views.static.serve', {'document_root': '../flex/bin-debug/', 'path': 'nonProfitManager.html'}),
  ('^(?P<path>\w+)$', 'django.views.static.serve', {'document_root': '../flex/bin-debug/'}),
)
