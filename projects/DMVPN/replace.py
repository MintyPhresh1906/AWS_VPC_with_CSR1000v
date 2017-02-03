import sys

for arg in sys.argv:
    VPCNumber = arg

replacements = {'XXX':VPCNumber, 'YYY':'00'}

with open('TEMPLATES/FULLTEMPLATE.yml') as infile, open('tmp{}/FULLTEMPLATE.yml'.format(VPCNumber), 'w') as outfile:
    for line in infile:
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        outfile.write(line)

with open('TEMPLATES/variables.tf') as infile, open('VPCs/{}/variables.tf'.format(VPCNumber), 'w') as outfile:
    for line in infile:
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        outfile.write(line)
