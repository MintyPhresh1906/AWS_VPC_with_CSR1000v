import sys

f = open('dictionary')
form = f.readline()
firstline = form
secondline = firstline.strip()
infile = [secondline]
replacements = {'"public_ip": "':'', '",':''}
for line in infile:
    for src, target in replacements.iteritems():
        line = line.replace(src, target) 
print line

f.close()
