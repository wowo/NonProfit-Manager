from django.conf.urls.defaults import *
from members import gateway

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
  (r'^admin/', include(admin.site.urls)),
  ('^gateway/$', gateway.echoGateway),
)
