from pyamf.remoting.gateway.django import DjangoGateway

import members.models as models

import logging
logging.basicConfig(
  level=logging.DEBUG,
  format='%(asctime)s %(levelname)-5.5s [%(name)s] %(message)s'
)

services = {
    'Members': models
    # could include other functions as well
}

echoGateway = DjangoGateway(services)
