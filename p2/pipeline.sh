#!/bin/bash

# creates csv file with statistics
# usage: ./pipeline.sh

# Run and time your code. Your study should investigate data sizes of 10^2, 10^3, 10^4, 10^5 and 10^6, with 200 samples each.


TIMEFORMAT=%R # for BASH time command to get real time


# echo '"Sample Number","Language","Time","Number of Partitioning Stages","Number of Exchanges","Number of Compares"' > ${sortMethod}.csv
# echo '"Sample Number","Language","Time","Number of Recursive Calls","Number of Transitions","Number of Compares"' > ${sortMethod}.csv

for algorithm in {quickselect,quicksort,deterministicselect}; do
  outputcsv=${algorithm}.csv
  # echo $algorithm
  echo '"Sample Number","algorithm","fileSize","kvalue","Time"' > $outputcsv
done # for all algorithms


for fileSize in {100,1000,10000,100000,1000000}; do
  echo "filesize $fileSize"
  for fileNum in $(seq -f "%03g" 1 200); do

    # generate fileSize random numbers from 1 to 1,000,000
    randfile=randNums.txt
    python randGen.py $fileSize 1000000

    # find kth element
    kvalue=$(( $RANDOM % $fileSize ))

    for algorithm in {quickselect,quicksort,deterministicselect}; do
      outputcsv=${algorithm}.csv

      echo -n "${fileNum},${algorithm},${fileSize},${kvalue}," >> $outputcsv
      echo $({ time python2.7 ./${algorithm}.py $randfile $kvalue ; } 2>&1 >/dev/null | tr -d '\n' ) >> $outputcsv
      # stats=$( ./${sortMethod}_stats.out $randfile $extraArgument )
      # echo $(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\1,\2,\3/' <<<$stats ) >> $outputcsv
    done # for all algorithms

  done # for all files
done # for all file sizes

rm -f $randfile 

echo "done pipeline"

