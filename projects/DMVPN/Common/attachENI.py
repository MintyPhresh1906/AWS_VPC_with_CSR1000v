import sys

replacements = {'#':'', 'YYY':'00'}

with open('vpc.tf') as infile, open('vpcENI.tf', 'w') as outfile:
    for line in infile:
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        outfile.write(line)
