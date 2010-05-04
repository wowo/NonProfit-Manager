from pyamf.remoting.gateway.django import DjangoGateway
import members.models as models
from members.mongoModels import Award
import logging
import pyamf

logging.basicConfig(
  filename='/tmp/django.log',
  level=logging.DEBUG,
  format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
)

pyamf.register_class(models.Member, 'models.Member')
pyamf.register_class(Award, 'members.mongoModels.Award')

services = {
  'Members': models.Member,
  'Awards': Award,
}

echoGateway = DjangoGateway(services, logger=logging)
