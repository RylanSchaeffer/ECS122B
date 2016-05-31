#!/bin/bash

# creates csv file with statistics
# usage: ./pipeline.sh sortExecutable NumFilesToSort NumsToSort

if [ $# -ne 3 ]; then
  echo "usage: ./pipeline.sh sortExecutable NumFilesToSort NumsToSort"
  exit
fi

TIMEFORMAT=%R # for BASH time command to get real time

if $(grep -q "quicksort" <<<$1 ); then
  sortMethod=quicksort
  echo $sortMethod
  g++ -std=c++11 -Wall -o quicksort_stats.out quicksort_stats.cpp
  g++ -std=c++11 -Wall -o quicksort_timed.out quicksort_timed.cpp

  echo '"Sample Number","Language","Time","Number of Partitioning Stages","Number of Exchanges","Number of Compares"' > ${sortMethod}.csv

  extraArgument="10"

elif $(grep -q "mergesort" <<<$1 ); then
  sortMethod=mergesort
  echo $sortMethod
  g++ -std=c++11 -Wall -o mergesort_stats.out mergesort_stats.cpp
  g++ -std=c++11 -Wall -o mergesort_timed.out mergesort_timed.cpp

  echo '"Sample Number","Language","Time","Number of Recursive Calls","Number of Transitions","Number of Compares"' > ${sortMethod}.csv

  extraArgument=""
fi

outputcsv=${sortMethod}.csv

for fileNum in $(seq -f "%03g" 1 $2); do

  # ./genFile.sh 100000
  # generate N random numbers from 1 to 100,000
  # N is specified on the command line
  randfile=randNums.txt
  echo $3 > $randfile
  for count in $(seq 1 $3); do
    echo -n $(( $RANDOM % 100000 ))" " >> $randfile
  done

  echo -n "${fileNum}," >> $outputcsv
  echo -n "$(cat version.txt)," >> $outputcsv
  echo -n $({ time ./${sortMethod}_timed.out $randfile $extraArgument ; } 2>&1 | tr -d '\n' ), >> $outputcsv
  stats=$( ./${sortMethod}_stats.out $randfile $extraArgument )
  echo $(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\1,\2,\3/' <<<$stats ) >> $outputcsv


done # for all files






rm -f $randfile 
# make clean
rm -f ./*.out
# rm -rf ./*.out.dSYM