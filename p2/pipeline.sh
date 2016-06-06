#!/bin/bash

# creates csv file with statistics
# usage: ./pipeline.sh

# Run and time your code. Your study should investigate data sizes of 10^2, 10^3, 10^4, 10^5 and 10^6, with 200 samples each.


TIMEFORMAT=%R # for BASH time command to get real time


outputcsv=results.csv

echo '"Sample Number","listLength","kvalue","quickselect","quicksort","deterministicselect"' > $outputcsv


for fileSize in {100,1000,10000,100000,1000000}; do
  echo "filesize $fileSize"
  for fileNum in $(seq -f "%03g" 1 200); do

    # generate fileSize random numbers from 1 to 1,000,000
    randfile=randNums.txt
    python randGen.py $fileSize 1000000

    # find kth element
    kvalue=$(( $RANDOM % $fileSize ))

    echo -n "${fileNum},${fileSize},${kvalue}," >> $outputcsv

    for algorithm in {quickselect,quicksort,deterministicselect}; do
      echo -n $({ time python2.7 ./${algorithm}.py $randfile $kvalue ; } 2>&1 >/dev/null | tr -d '\n' ), >> $outputcsv
    done # for all algorithms
    echo "" >> $outputcsv

  done # for all files
done # for all file sizes

rm -f $randfile 

echo "done pipeline"

