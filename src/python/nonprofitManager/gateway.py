from pyamf.remoting.gateway.django import DjangoGateway
import nonprofitManager.models as models
from nonprofitManager.mongoModels import Award, Member
import logging
import pyamf
import pymongo

logging.basicConfig(
  filename='/tmp/django.log',
  level=logging.DEBUG,
  format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
)

pyamf.register_class(Member, 'Member')
pyamf.register_class(Award, 'Award')

services = {
  'Members': Member,
  'Awards': Award,
}

echoGateway = DjangoGateway(services, logger=logging)
