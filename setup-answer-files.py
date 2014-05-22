#!/usr/bin/python

import os
import sys

os.chdir("./answer_files")
dirs = os.listdir(".")

try:
    for d in dirs:
        os.chdir(d)
        files = os.listdir(".")
        curdir = os.getcwd()
        os.chdir("../")
        for f in files:
            filename = curdir + '/' + f
            command = "sed -i 's/openssh.ps1/openssh.ps1\ -password\ %r/g' %r" % (sys.argv[1], filename)
            os.system(command)

except:
    print "Could not parse file"
