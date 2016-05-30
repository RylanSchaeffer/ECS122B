#!/usr/bin/env bash
# first argv : number of tests (number of files to sort)
# second argv : number of integers in each sample

failed=0;
input="inputX.txt"
quickoutput="quickoutputX.txt"
mergeoutput="mergeoutputX.txt"

# for each sample
for n in $(seq 1 $1);do

    # generate file with random numbers to sort
    inputfile=${input/X/$n}

    # insert random numbers into file
    array=()
    for iter in $(seq 0 $2);do
        array[$iter]=$RANDOM
    done
    echo ${array[*]} > $inputfile

    # run quicksort_verbose and save output
    # use k = 10 for insertionsort
    outputfile1=${quickoutput/X/$n}
    python2.7 quicksort_verbose.py $inputfile 10 > $outputfile1


    # run mergesort_verbose and save output
    outputfile2=${mergeoutput/X/$n}
    python2.7 mergesort_verbose.py $inputfile > $outputfile2

    # compare outputs of mergesort and quicksort
    # if outputs are not identical
    if ! cmp $outputfile1 $outputfile2; then

        # increment failed counter
        failed=$(($failed+1))

        # save mismatched files
        failed1="quicksort_failed_text_Z.txt"
        failed1=${failed1/Z/$n}
        failed2="mergesort_failed_test_Z.txt"
        failed2=${failed2/Z/$n}
        cp $outputfile1 $failed1
        cp $outputfile2 $failed2
    fi

    rm $outputfile1
    rm $outputfile2

done

# print results of tests
if [ $failed == 0 ]; then
    echo "All tests passed."
else
    echo $failed "tests failed."
fi

# remove generated files
rm input*.txt