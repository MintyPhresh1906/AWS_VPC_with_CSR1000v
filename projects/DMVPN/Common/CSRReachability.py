import pyping
import sys

for arg in sys.argv:
   HOST = arg

response = pyping.ping(HOST)

if response.ret_code == 0:
   print("reachable")
   exit()

while response.ret_code != 0:
   response = pyping.ping(HOST)   
   print("waiting...")
else:
    print("The CSR1000v has initialized")
