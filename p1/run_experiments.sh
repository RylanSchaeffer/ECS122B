#!/usr/bin/env bash

# first argv : executable to run
# second argv : number of samples
# third argv : number of integers in each sample

# determine output file name
outfile=${1/_*.py/.csv}

# set time format to real only
TIMEFORMAT=%R

# if given mergesort
if [ $outfile == "mergesort.csv" ];then

    # create column headers
    echo -e "\"Sample Number\", \"Language\", \"Time\", \"Number of Partitioning Stages\", \"Number of Exchanges\", \"Number of Compares\"" > $outfile

    # create input file
    input="input.txt"

    # specify that the language is Python
    language="Python2.7"

    # for the specified number of samples
    for n in $(seq 1 $2);do

        # generate file with random numbers to sort
        array=()
        for iter in $(seq 0 $3);do
            array[$iter]=$RANDOM
        done
        echo ${array[*]} > $input

        # store time of timed version
        time=$({ time python2.7 mergesort_timed.py $input;} 2>&1)

        # store output of timed version
        temp=$(python2.7 $1 $input)

        # number of recursive calls
        recursive=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\1/' <<< $temp)

        # number of transitions
        transitions=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\2/' <<< $temp)

        # number of compares
        compares=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\3/' <<< $temp)

        # append to csv file
        echo -e "$n, $language, $time, $recursive, $transitions, $compares" >> $outfile

    done

    rm input.txt

elif [ $outfile == "quicksort.csv" ]; then

    # create column headers
    echo "\"Sample Number\", \"Language\", \"Time\", \"Number of Recursive Calls\", \"Number of Transitions\", \"Number of Compares\"" > $outfile

    # create input file
    input="input.txt"

    # specify that the language is Python
    language="Python2.7"

    # for the specified number of samples
    for n in $(seq 1 $2);do

        # generate file with random numbers to sort
        array=()
        for iter in $(seq 0 $3);do
            array[$iter]=$RANDOM
        done
        echo ${array[*]} > $input

        # store time of timed version
        time=$({ time python2.7 quicksort_timed.py $input 10;} 2>&1)

        # store output of timed version
        temp=$(python2.7 $1 $input 10)

        # number of recursive calls
        partition=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\1/' <<< $temp)

        # number of transitions
        exchanges=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\2/' <<< $temp)

        # number of compares
        compares=$(sed 's/.* \([0-9]*\) .* \([0-9]*\) .* \([0-9]*\)/\3/' <<< $temp)

        # append to csv file
        echo -e "$n, $language, $time, $partition, $exchanges, $compares" >> $outfile

    done

    rm input.txt
else
    echo "Bad input file"
fi

# print the header row to a .csv file
#echo "" >

#
#echo -n $({ time ./${sortMethod}_timed.out $randfile $extraArgument ; } 2>&1 | tr -d '\n' ), >> $outputcsv
#
#time=$( { /usr/bin/time -f %E "$1"_timed input.txt ; } 2>&1 )
#
#
#Here, a file called 'ls-l.txt' will be created and it will contain what you would see on the screen if you type the command 'ls -l' and execute it.


