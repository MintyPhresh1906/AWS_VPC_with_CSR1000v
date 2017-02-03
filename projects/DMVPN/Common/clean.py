import sys

#for arg in sys.argv:
#    VPCNumber = arg

with open('FULLTEMPLATE.yml') as infile:
    with open('CLEANTEMPLATE.yml','w') as outfile:
        for i,line in enumerate(infile):
            if i==0:
                outfile.write("---\n")
            elif i==0:
                pass
            else:
                outfile.write(line)
