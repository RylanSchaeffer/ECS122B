#!/bin/bash

# usage: ./sanity_check.sh


# failed=0

echo "testing 100 files with 1000 numbers"

# for fileNum in $(seq -f "%04g" 1 $1); do
for fileNum in $(seq -f "%04g" 1 100); do

  # generate 1000 random numbers from 1 to 100,000
  randfile=randNums.txt
  python randGen.py 1000 1000000

  # find kth element
  kvalue=$(( $RANDOM % 1000 + 1))

  quickselectOut=selectOut.txt
  quicksortOut=sortOut.txt
  determineOut=deterOut.txt

  python2.7 ./quickselect.py $randfile $kvalue > $quickselectOut
  python2.7 ./quicksort.py $randfile $kvalue > $quicksortOut
  python2.7 ./deterministicselect.py $randfile $kvalue > $determineOut

  # test quicksort versus quickselect results
  if [[ $(diff --brief $quicksortOut $quickselectOut) ]]; then
    # files differ
    # cp $quicksortOut quicksort_failed_test_${fileNum}.txt
    # cp $mergesortOut mergesort_failed_test_${fileNum}.txt
    # let failed++
    echo "file number $fileNum"
    echo "Sanity Check failed. You've gone insane."
    exit 1

  # test quicksort versus deterministicselect results
  elif [[ $(diff --brief $quicksortOut $determineOut) ]]; then
    echo "file number $fileNum"
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
# rm -f ./*.out
# rm -rf ./*.out.dSYM


