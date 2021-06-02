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

die() {
	echo >&2 "$@"
	exit 1
}
[ "$#" -ge 2 ] || die "requires at least two arguments (numMatches, numMeasurements), $# provided"

NUMMATCHES=$1
NUMMEASUREMENTS=$2

mkdir $NUMMATCHES"Matches/"

echo "Event query"
./evaluate.py 'http://10.34.58.65:2222/getAreaEvents?shape=rectangle&coordinates={%22bottomLeftX%22:%2233.38%22,%22bottomLeftY%22:%2216.46%22,%22upperRightX%22:%2249.42%22,%22upperRightY%22:%22-16.67%22}&eventFilters={}&teamFilters={}&playerFilters={}&periodFilters={}&timeFilter={}&sportFilter={%27sport%27:football}&matchFilters={}' $NUMMEASUREMENTS > $NUMMATCHES"Matches/"$NUMMATCHES"Matches_eventQuery.dat"

echo "Movement query"
./evaluate.py 'http://10.34.58.65:2222/getMotionPath?shape=polygon&coordinates={%22vertices%22:[[-2.08,-24.48],[-3.45,-24.22],[-9.71,-24.22],[-10.45,-24.08],[-11.35,-24.08],[-11.41,-24.06],[-12.78,-23.80],[-13.50,-23.80],[-14.24,-23.66],[-17.15,-23.66],[-17.88,-23.52],[-22.69,-23.52],[-23.43,-23.38],[-23.89,-23.38],[-23.95,-23.36],[-24.68,-23.22],[-25.65,-23.04],[-26.14,-22.80],[-26.72,-22.66],[-27.45,-22.39],[-28.18,-22.11],[-29.34,-21.88],[-29.49,-21.83],[-30.08,-21.55],[-30.95,-20.99],[-31.06,-20.94],[-31.11,-20.89],[-32.27,-20.15],[-33.00,-19.87],[-33.07,-19.83],[-33.15,-19.77],[-33.88,-19.21],[-34.90,-18.23],[-35.63,-17.54],[-36.36,-16.56],[-36.82,-15.92],[-37.04,-15.57],[-37.33,-14.87],[-37.77,-13.89],[-37.91,-13.43],[-37.93,-13.25],[-38.08,-12.41],[-38.08,-11.43],[-38.35,-10.12],[-38.52,-9.54],[-38.52,-9.05],[-38.66,-8.21],[-38.66,-7.37],[-38.93,-6.06],[-38.95,-6.02],[-38.95,-5.98],[-39.10,-5.27],[-39.10,-5.14],[-39.37,-3.83],[-39.47,-3.64],[-39.66,-2.71],[-40.44,-1.60],[-41.60,-0.85],[-42.97,-0.59],[-44.34,-0.85],[-45.50,-1.60],[-46.27,-2.71],[-46.55,-4.02],[-46.55,-4.44],[-46.27,-5.75],[-46.13,-6.17],[-46.13,-6.17],[-45.98,-6.87],[-45.91,-7.08],[-45.82,-7.52],[-45.82,-8.21],[-45.67,-9.05],[-45.67,-9.89],[-45.40,-11.20],[-45.23,-11.78],[-45.23,-12.41],[-45.09,-13.25],[-44.94,-14.23],[-44.67,-15.54],[-44.38,-16.51],[-43.94,-17.49],[-43.65,-18.19],[-43.21,-18.89],[-42.43,-20.00],[-41.41,-21.40],[-40.68,-22.38],[-39.96,-23.08],[-38.93,-24.06],[-38.21,-24.62],[-37.48,-25.18],[-36.32,-25.92],[-35.73,-26.20],[-35.55,-26.27],[-34.57,-26.90],[-33.69,-27.32],[-32.82,-27.88],[-32.23,-28.15],[-31.50,-28.43],[-30.34,-28.66],[-30.19,-28.71],[-29.46,-28.99],[-28.88,-29.13],[-28.29,-29.41],[-26.93,-29.67],[-26.57,-29.73],[-25.82,-29.97],[-24.45,-30.23],[-23.58,-30.23],[-22.84,-30.37],[-18.03,-30.37],[-17.30,-30.51],[-14.68,-30.51],[-13.95,-30.65],[-13.45,-30.65],[-13.42,-30.67],[-12.05,-30.93],[-11.03,-30.93],[-10.30,-31.07],[-3.45,-31.07],[-2.08,-30.81],[-0.92,-30.07],[-0.14,-28.96],[0.13,-27.65],[-0.14,-26.34],[-0.92,-25.22]]}&eventFilters={}&teamFilters={}&playerFilters={filter0:BALL}&periodFilters={}&timeFilter={}&sportFilter={%27sport%27:football}&matchFilters={}' $NUMMEASUREMENTS > $NUMMATCHES"Matches/"$NUMMATCHES"Matches_movementQuery.dat"

echo "Quantitative analysis"
./evaluate.py 'http://10.34.58.65:2222/analyzePlayers?user=Select%20User&discipline&players=A4,A5,A8,A9&parameters=gamesPlayed,gamesWon,gamesLost,gamesDrawn,winPercentage,successfulPassEvent,misplacedPassEvent,passAccuracy,longPasses,shortPasses,avgPassLength,avgPassVelocity,avgPacking,leftPasses,rightPasses,forwardPasses,backwardPasses,goalEvent,shotOnTargetEvent,shotOffTargetEvent,totalShots,avgShotLength,avgShotVelocity,successfulTakeOnEvent,failedTakeOnEvent,DribblingStatistic,interceptionEvent,playerFoulsEvent,playerGetFouledEvent,clearanceEvent,timeSpeedZone1,timeSpeedZone2,timeSpeedZone3,timeSpeedZone4,timeSpeedZone5,timeSpeedZone6,cornerkickEvent,throwinEvent,freekickEvent,totalTouches,playerOn,playerOff&matches=' $NUMMEASUREMENTS > $NUMMATCHES"Matches/"$NUMMATCHES"Matches_quantitativeAnalysis.dat"
