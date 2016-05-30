__author__ = 'rylan'

# quicksort
# Based on http://www.algolist.net/Algorithms/Sorting/Quicksort

import random
import sys

def main(filename):

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    quicksort(array, 0, len(array) - 1)


def quicksort(array, low, high):

    i = low
    j = high

    pivot = array[(low + high)/2]

    while i <= j:
        while array[i] < pivot:
            i += 1
        while array[j] > pivot:
            j -= 1
        if i <= j:
            array[i], array[j] = array[j], array[i]
            i += 1
            j -= 1

    if low < j:
        quicksort(array, low, j)
    if i < high:
        quicksort(array, i, high)

    return


if __name__ == '__main__':
    main(sys.argv[1])
