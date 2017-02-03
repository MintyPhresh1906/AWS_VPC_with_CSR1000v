import sys

for arg in sys.argv:
    HOSTIP = arg

replacements = {'ZZZ':HOSTIP, 'YYY':'00'}

with open('hostsTemplate') as infile, open('hosts', 'w') as outfile:
    for line in infile:
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        outfile.write(line)
