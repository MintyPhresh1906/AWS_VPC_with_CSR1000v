import pyping
import sys
import time

counter = 0

for arg in sys.argv:
   HOST = arg

response = pyping.ping(HOST)

if response.ret_code == 0:
   print "reachable"
   exit()

while response.ret_code != 0:
   response = pyping.ping(HOST)   
   print "waiting..."
else:
    print "The CSR1000v has initialized"


print "The CSR1000v is now reachable. We'll wait another 3 minutes to ensure the router is fully inialized and ready for configuration."
while counter != 180:
  print "waiting, %d of 180 seconds......" % counter
  time.sleep(5)
  counter += 5
