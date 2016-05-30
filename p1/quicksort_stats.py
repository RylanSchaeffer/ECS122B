__author__ = 'rylan'

# write timed version, then verbose version, then stats version

# Based on http://www.algolist.net/Algorithms/Sorting/Quicksort

# Quicksort with the following two modifications:
#   - randomly pick a pivot instead of choosing the last element. Second,
#   - use Insertion Sort if the sub-array has k elements or less, where k is specified to the program as a
#       command-line argument

import random
import sys

k = 1

partitioning_stages = 0
exchanges = 0
compares = 0

def main(filename, cutoff):

    global k
    global partitioning_stages
    global exchanges
    global compares

    k = int(cutoff)

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    quicksort(array, 0, len(array) - 1)

    print 'Partitioning Stages: ' + str(partitioning_stages)
    print 'Exchanges: ' + str(exchanges)
    print 'Compares: ' + str(compares)


def quicksort(array, low, high):

    global k
    global partitioning_stages
    global exchanges
    global compares

    if (high - low + 1) <= k:
        insertionsort(array, low, high)
        return

    i = low
    j = high

    pivot = array[random.randint(low, high)]

    while i <= j:
        while array[i] < pivot:
            compares += 1
            i += 1
        compares += 1
        while array[j] > pivot:
            compares += 1
            j -= 1
        compares += 1
        if i <= j:
            array[i], array[j] = array[j], array[i]
            i += 1
            j -= 1
            exchanges += 1

    partitioning_stages += 1

    if low < j:
        quicksort(array, low, j)
    if i < high:
        quicksort(array, i, high)

    return


def insertionsort(array, low, high):

    global exchanges
    global compares

    for i in range(low+1, high+1):
        current_value = array[i]
        pos = i

        while pos > 0 and array[pos-1] > current_value:
            compares += 1
            array[pos] = array[pos-1]
            exchanges += 1
            pos -= 1

        compares += 1
        array[pos] = current_value
        exchanges += 1

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
