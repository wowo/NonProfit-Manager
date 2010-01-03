import logging
import members.models as models
from pyamf.remoting.gateway.django import DjangoGateway
import pyamf

logging.basicConfig(
  filename='/tmp/django.log',
  level=logging.DEBUG,
  format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
)


pyamf.register_class(models.Member, 'models.Member')
#pyamf.register_package(models, 'models')

services = {
    'Members': models
}

echoGateway = DjangoGateway(services)
