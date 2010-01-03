#!/usr/bin/python2.6
# pyamf has RemotingService act as a client for AMF calls
from pyamf.remoting.client import RemotingService
gw = RemotingService('http://127.0.0.1:8000/gateway/')
#To get service proxy for ContactService, which is defined in the gateway.py
service = gw.getService('Members')
# To check the objects available in the model
print "----------- viewer ------------"
print service
