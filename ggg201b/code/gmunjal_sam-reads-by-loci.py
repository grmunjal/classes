#!/usr/bin/env python

from sys import argv

infile = argv[1]                      # get in-file name from cmd line
outfile = argv[2]                     # get out-file name from cmd line

openin = open(infile)               # open in-file in read mode
openout = open(outfile, 'w')        # open out-file in write mode

locuscount = {}                     # setup an empty dictionary for counts
locuscount["*"] = 0

while True:                         # loop over file
    line = openin.readline()        # read in one line
    if line == "":                  # leave loop if end of file
        break
    elif line[0] == "@":                    # if line is header line
        line = line.split("\t")             # split line by tab
        name = str(line[1]).split(":")      # split 2nd element of prev. split
        name = str(name[1]).split(".")      # split 2nd element of prev split
        name = str(name[0])                 # recycle name variable as loc name
        locuscount[name] = 0                # make a dictionary entry for loc
    else:
        line = line.split("\t")             # if non-header line split by tab
        flag = line[1]                      # retrieve flag value
        name = line[2].split(".")           # split line to retrieve locus name
        name = str(name[0])                 # recycle variable for loc name
        if flag == 0 or 16:                 # if read is good
            locuscount[name] += 1           # count it!
        else:
            pass

for name in locuscount:  # write dictionary to file (with table-ish formatting)
    openout.write(name + "\t" + str(locuscount[name]) + "\n")

openin.close()                              # close all open files
openout.close()





