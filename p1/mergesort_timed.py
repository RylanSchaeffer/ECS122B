__author__ = 'rylan'

# write timed version, then verbose version, then stats version

# Based on http://algs4.cs.princeton.edu/22mergesort/Merge.java.html

# Mergesort with the following two modifications:
#   - INFINITY sentinel values
#   - Three sub-arrays instead of two

import random
import sys


def main(filename):

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    mergesort(array, 0, len(array)-1)


def mergesort(array, low, high):

    if high <= low:
        return

    cut1 = low + (high-low)/3
    cut2 = low + 2*(high-low)/3

    mergesort(array, low, cut1)
    mergesort(array, cut1+1, cut2)
    mergesort(array, cut2+1, high)

    b = array[low:(cut1+1)]
    c = array[(cut1+1):(cut2+1)]
    d = array[(cut2+1):(high+1)]

    b.append(float('inf'))
    c.append(float('inf'))
    d.append(float('inf'))

    i = 0
    j = 0
    k = 0
    for l in range(low, high+1):
        if d[k] <= b[i] and d[k] <= c[j]:
            array[l] = d[k]
            k += 1
        elif c[j] <= b[i] and c[j] <= d[k]:
            array[l] = c[j]
            j += 1
        else:
            array[l] = b[i]
            i += 1

if __name__ == '__main__':
    main(sys.argv[1])
