#!/user/bin/python
#You MUST put in your own gridspot api key for this to work
import httplib
import urllib2
import json
import string
import os
import subprocess
import time
import uuid
import thread

def setup(client): #run setup on the new client and start minerd
	print client[0]
	ip="{0}".format(client[0])
	port="{0}".format(client[1])
	uniqueid="{0}".format(uuid.uuid4())
#you can replace the "gridspot" key with your own
	command=["knife","bootstrap",ip,"-p",port,"-x","gridspot_user","-i","~/gridspot","-N",uniqueid,"--sudo","--run-list","role[miner]"]
	subprocess.Popen(command)

running_instance_addresses=[]
#get all running instances
#### Enter Gridspot API Key On Below Line #####
request=urllib2.Request("https://gridspot.com/compute_api/v1/list_instances?api_key=ENTER API KEY HERE")
jsonresult=urllib2.urlopen(request)
values=json.load(jsonresult)
#get all ssh address:ports
for entry in values['instances']:
	if str(entry['vm_ssh_wan_ip_endpoint']) != 'None':
#		ssh_address=string.split(str(entry['vm_ssh_wan_ip_endpoint']),":")
#		print ssh_address
		print str(entry['vm_ssh_wan_ip_endpoint'])

