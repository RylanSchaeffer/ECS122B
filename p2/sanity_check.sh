#!/bin/bash

# usage: ./sanity_check.sh

# if [ $# -ne 2 ]; then
#   # echo $# 
#   # "$#" is command line arguments
#   echo "usage: ./sanity_check.sh NumFilesToSort NumsToSort"
#   exit
# fi


# failed=0

echo "testing 100 files with 1000 numbers"

# for fileNum in $(seq -f "%04g" 1 $1); do
for fileNum in $(seq -f "%04g" 1 100); do

  # generate 1000 random numbers from 1 to 100,000
  randfile=randNums.txt
  # for count in $(seq 1 1000); do
  #   nums="$nums $(( $RANDOM % 1000000 + 1))"
  # done
  # echo -n $nums > $randfile
  python randGen.py 1000 1000000 > $randfile

  # find kth element
  kvalue=$(( $RANDOM % 1000 + 1))

  quickselectOut=RylansBooty.txt
  quicksortOut=RylanLovesBeyonce.txt
  determineOut=RylansIsBeyonce.txt

  python ./quickselect.py $randfile $kvalue > $quickselectOut
  python ./quicksort.py $randfile $kvalue > $quicksortOut
  # python ./deterministicselect.py $randfile $kvalue > $determineOut

  # test quicksort versus quickselect results
  if [ $(diff --brief $quicksortOut $quickselectOut) ]; then
    # files differ
    # cp $quicksortOut quicksort_failed_test_${fileNum}.txt
    # cp $mergesortOut mergesort_failed_test_${fileNum}.txt
    # let failed++
    echo "Sanity Check failed. You've gone insane."
    exit 1

  # test quicksort versus deterministicselect results
  elif [ $(diff --brief $quicksortOut $determineOut) ]; then
    echo "Sanity Check failed. You've gone insane."
    exit 1
  fi

done # for all files

echo All tests passed.

# if [ $failed -eq 0 ]; then
#   # no failed
#   echo All tests passed.
# else
#   echo $failed tests failed.
# fi

rm -f $randfile $quickselectOut $quicksortOut $determineOut
# rm -f $quicksortOut $mergesortOut $randfile $realsortOut
# rm -f $quicksortOut $mergesortOut $randfile $realsortOut
# make clean
# rm -f ./*.out
# rm -rf ./*.out.dSYM


# ./mergesort_stats.out randNums.txt
# ./mergesort_timed.out randNums.txt

# ./quicksort_stats.out randNums.txt 10
# ./quicksort_timed.out randNums.txt 10
