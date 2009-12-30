from pyamf.remoting.gateway.django import DjangoGateway

import members.models as models

services = {
    'Members': models
    # could include other functions as well
}

echoGateway = DjangoGateway(services)
