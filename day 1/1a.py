#!/usr/bin/python
import csv

with open("coordinates.csv") as c:
	path = c.readlines()


for point in path:
	coords = point.split(",")
	print coords[1]
	

c.close()

