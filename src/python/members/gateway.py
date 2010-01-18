from pyamf.remoting.gateway.django import DjangoGateway
import members.models as models
import logging
import pyamf

logging.basicConfig(
  filename='/tmp/django.log',
  level=logging.DEBUG,
  format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
)

pyamf.register_class(models.Member, 'models.Member')

services = {
  'Members': models.Member
}

echoGateway = DjangoGateway(services, logger=logging)
