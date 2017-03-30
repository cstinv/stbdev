import urllib
import urllib2
import json
import sys
import time

HostIP="192.168.10.40"
tvheadendURL="http://192.168.10.40:9981"
tvhuser="tvheadend"
tvhpass="tvheadend"

passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
passman.add_password(None, tvheadendURL, tvhuser, tvhpass)
authhandler = urllib2.HTTPDigestAuthHandler(passman)
opener = urllib2.build_opener(authhandler)
urllib2.install_opener(opener)


# Get the DVB-T tuner by iterating through the adapters and tuners
def GetDvbtTuner(opener): 
  GetAdaptersURL="http://"+HostIP+":9981/api/hardware/tree"

  # Load the DVB adapters in the system
  # Create input params for JSON request
  data=urllib.urlencode({'uuid' : 'root'})
  req = urllib2.Request(GetAdaptersURL,data)
  f = opener.open(req)
  adapters = json.loads(f.read())

  # Loop through adapters and look for dvb-t tuner
  print "Loop through adapters"
  for adapter in adapters:
    data=urllib.urlencode({'uuid' : adapter['uuid']})
    print "data="+data # DELETE
    req = urllib2.Request(GetAdaptersURL,data)
    f = opener.open(req)
    tuners = json.loads(f.read())
    for tuner in tuners:
      print "Tuner = "+str(tuner['class']) #DELETE
      if tuner['class']=="linuxdvb_frontend_dvbt":
        return tuner
  return None



# Get the DVB-T network   
def GetDvbtNetwork(opener): 
  GetNetworksURL="http://"+HostIP+":9981/api/mpegts/network/grid"

  req = urllib2.Request(GetNetworksURL,"sort=networkname,dir=ASC")
  f = opener.open(req)
  networks = json.loads(f.read())

  for network in networks['entries']:
    if network['networkname'] == 'DVBT':
      return network
  return None


# Add a DVB-T network 
def AddDvbtNetwork(opener): 
  AddNetworkURL="http://"+HostIP+":9981/api/mpegts/network/create"

  confpars={}
  confpars['networkname']='DVBT'
  confpars['autodiscovery']=2
  confpars['skipinitscan']=True
  confpars['idlescan']=False
  confpars['scanfile']="dvbt/auto/dvb-t_auto-Default"

  data=urllib.urlencode({'class' : 'dvb_network_dvbt', 'conf' : json.dumps(confpars)})
  req = urllib2.Request(AddNetworkURL,data)
  f = opener.open(req)
  pars = json.loads(f.read())



# Set node parameters (for instance for associating network to tuner
def SetNodePars(opener,setpars): 
  SetTunerParamsURL="http://"+HostIP+":9981/api/idnode/save"

  data=urllib.urlencode({'node' : json.dumps(setpars)})
  req = urllib2.Request(SetTunerParamsURL,data)
  f = opener.open(req)
  pars = json.loads(f.read())

# Force network scan
def ForceScan(opener,setpars):
  ForceScanURL="http://"+HostIP+":9981/api/mpegts/network/scan"

  data=urllib.urlencode({'uuid' : setpars['uuid']})
  print "data="+data   #DELETE
  req = urllib2.Request(ForceScanURL,data)
  f = opener.open(req)
  pars = json.loads(f.read())
  print "Force network scan parts="+str(pars)


# Map services to channels
def MapAllServices(opener): 
  SetTunerParamsURL="http://"+HostIP+":9981/api/service/mapper/start"

  req = urllib2.Request(SetTunerParamsURL)
  f = opener.open(req)
  pars = json.loads(f.read())




#============================= MAIN SCRIPT STARTS HERE ==============================

# FInd DVB-T tuner
print "Finding DVB-T tuner"
tuner=GetDvbtTuner(opener)
if tuner==None:
  print "DVB-T tuner not found"
  sys.exit(1)

# Add DVB-T network
print "Add DVB-T network if necessary"
network=GetDvbtNetwork(opener) 
if network==None:
  print "Adding DVB-T network"
  AddDvbtNetwork(opener)
  network=GetDvbtNetwork(opener) 
  if network==None:
    print "DVB-T network not found"
    sys.exit(1)


# Load network adapter data
# Create JSON request to associate network with adapter
print "Associating DVBT network with adapter"
setpars={}
setpars['enabled']=True
#setpars['displayname']='Silicon Labs Si2168 : DVB-T #0'
setpars['networks']=[network['uuid']]
setpars['uuid']=tuner['uuid']
setpars['ota_epg']=True
setpars['initscan']=True
setpars['idlescan']=True
SetNodePars(opener,setpars) 

# Create JSON request to force a network scan
print "Forcing scan on DVBT network"
setpars={}
setpars['uuid']="[\""+tuner['uuid']+"\"]"
ForceScan(opener,setpars)

#Wait for scan to complete
print "Wait for network scan to complete"
network=GetDvbtNetwork(opener) 
if network==None:
  print "DVB-T network not found"
  sys.exit(1)
while ( network['scanq_length'] > 0 ):
  print "Scanning for channel muxes. Remaining muxes: "+str(network['scanq_length'])+". Services found: "+str(network['num_svc'])
  time.sleep(5)
  network=GetDvbtNetwork(opener) 

# Map services to channels
print "Mapping all services to channels"
MapAllServices(opener)




