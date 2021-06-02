#!/bin/bash

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

NUM=10

#http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo "n=1"
~/streamteam-cluster-scripts/clearDatabase.sh
mongorestore --gzip --host 10.34.58.65 --archive=/media/sf_Dumps/1.archive
./evaluateAll.sh 1 40
echo "--------------------------"

#https://www.cyberciti.biz/faq/bash-for-loop/
for (( n=2; n<=NUM; n++))
do
	echo "n="$n
	~/streamteam-cluster-scripts/clearDatabase.sh
	mongorestore --gzip --host 10.34.58.65 --archive=/media/sf_Dumps/$n.archive
	./evaluateEventMovementAndQuantitative.sh $n 40

	echo "--------------------------"
done
