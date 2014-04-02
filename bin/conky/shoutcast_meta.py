#!/usr/bin/env python2
import urllib2
import sys

request = urllib2.Request(sys.argv[1])
request.add_header('Icy-MetaData','1')
opener = urllib2.build_opener()

data=opener.open(request)
headers=True
while headers:
    line = data.readline()
    if line[0:11]=="icy-metaint":
        interval = int(line[12:])

    if line=="\r\n":
        headers=False

data.read(interval)
len=ord(data.read(1))*16
#print "Meta data is",len
print data.read(len)
