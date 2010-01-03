import logging
import members.models as models
from pyamf.remoting.gateway.django import DjangoGateway
import pyamf

try:
  logging.basicConfig(
    filename='/tmp/django.log',
    level=logging.DEBUG,
    format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
  )
  logging.debug('line 6')

  logging.debug('line 12')
  pyamf.register_class(models.Member, 'models.Member')
#pyamf.register_package(models, 'models')

  logging.debug('line 17')
  services = {
      'Members': models
  }

  echoGateway = DjangoGateway(services, logger=logging)
  logging.debug('line 23')
except Exception as inst:
   print type(inst)     # the exception instance
   print inst.args      # arguments stored in .args
   print inst           # __str__ allows args to printed directly
   logging.debug(type(inst))
   logging.debug(inst.args) 
   logging.debug(inst)
