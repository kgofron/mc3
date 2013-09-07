#!/usr/bin/env python

# Date: 2013/09/07
# Author: Wayne Lewis
#
# Description: Script to produce motor databases from CSV file from design
# report spreadsheet.
#
# Inputs: 	1 - Input data file
#			2 - Motor controller number

import sys

def usage():
  print 'Usage: create_motion_databases.py <input_file>\
 <motor_controller_number>'
  sys.exit()

def find_controller_column(line):

if len(sys.argv) != 3:
	usage()

input_file = open(sys.argv[1], 'r')

for line in input_file:
  print line

