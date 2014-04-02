#!/usr/bin/python3

import sys
import urllib
import urllib.request
import json
import csv

url = "http://api.openweathermap.org/data/2.5/weather?q=45377&units=imperial&lang=en"
data = urllib.request.urlopen(url).read()
data = json.loads(data.decode('utf-8'))
try:
    if sys.argv[1] == "condition":
        print(data['weather'][0]['description'])
    if sys.argv[1] == "temp":
    	print(str(round(data['main']['temp'])))
except KeyError:
    if sys.argv[1] == "condition":
        print("unknown")
    if sys.argv[1] == "temp":
        print("--")
