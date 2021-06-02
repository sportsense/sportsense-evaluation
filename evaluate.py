#!/usr/bin/python

#
# SportSense
# Copyright (C) 2019  University of Basel
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

import subprocess
import sys
import math

if len(sys.argv) != 3:
	sys.exit("Required parameters: <url> <n>")

url = sys.argv[1]
n = int(sys.argv[2])

print "URL: " + url
print "n: " + str(n)
print "------------------------------"

# Measure the time for curling the url n times
sum1 = 0.0
values = []
for i in range(n):
	# https://overloaded.io/timing-http-requests-curl
	command = 'curl -g -w %{time_total} -o /dev/null -s ' + url

	# https://stackoverflow.com/questions/7575284/check-output-from-calledprocesserror/8235171#8235171
	stringRes = subprocess.check_output(command.split(" "))
	stringRes = stringRes.replace(",",".")
	print "Run " + str(i+1) + ": " + stringRes

	floatRes = float(stringRes)
	values.append(floatRes)
	sum1 += floatRes
print "------------------------------"

#Calculate the mean
mean = sum1/n

# Calculate the variance and the standard deviation
variance = 0.0
for value in values:
	variance += (value-mean) * (value-mean)
variance /= (n-1)
std = math.sqrt(variance)

# Calculate median
values.sort()
if n%2 == 1:
	median = values[int(n/2)]
else:
	median = (values[int(n/2)-1] + values[int(n/2)]) / 2

print "Mean: " + str(mean)
print "Standard deviation: " + str(std)
print "Median: " + str(median)
print "Variance: " + str(variance)
