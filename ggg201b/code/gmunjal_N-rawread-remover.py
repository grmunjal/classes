#!/usr/bin/env python

from sys import argv
import os

infile = argv[1]                              # get in-file name from cmd line
outfile = argv[2]                             # get out-file name from cmd line
infile2 = "tempfile"                          # temporary file

openin = open(infile)                 # open in-file in read mode
openin2 = open(infile2, 'w')          # open temp file in write mode
openout = open(outfile, 'w')          # open out-file in write mode

i = 0                                 # variable for counting lines

while True:                           # loop over file
    openin2.write(openin.readline())  # get 250,000 reads from infile
    i += 1
    if i == 1000000:
        break

openin2 = open(infile2)                # open temp file in read mode
j = 0                                  # bad read count variable
while True:                            # loop over file
    header = openin2.readline()        # first line from file is header
    sequence = openin2.readline()      # second line is sequence
    plus = openin2.readline()          # third line is comment
    quality = openin2.readline()       # fourth line is quality

    if header == "":                   # break if end of file
        break
    elif "N" in sequence or "n" in sequence:   # count if read is bad (has N)
        j += 1
    else:                                  # write to out-file if read is good
        openout.write(header)              # writing in same order as in-file
        openout.write(sequence)
        openout.write(plus)
        openout.write(quality)

openin.close()                             # close all open files
openin2.close()
openout.close()

os.system("rm temp*")                      # remove temp file using unix command
print (j)                                  # print bad read count

