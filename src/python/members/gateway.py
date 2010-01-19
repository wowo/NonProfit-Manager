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
pyamf.register_class(models.Award, 'models.Award')

services = {
  'Members': models.Member,
  'Awards': models.Award,
}

echoGateway = DjangoGateway(services, logger=logging)
