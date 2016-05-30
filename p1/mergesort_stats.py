__author__ = 'rylan'

# write timed version, then verbose version, then stats version

# Based on http://algs4.cs.princeton.edu/22mergesort/Merge.java.html

# Mergesort with the following two modifications:
#   - INFINITY sentinel values
#   - Three sub-arrays instead of two

import random
import sys

recursive_calls = 0
transitions = 0
compares = 0


def main(filename):

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    mergesort(array, 0, len(array)-1)

    print 'Recursive Calls: ' + str(recursive_calls)
    print 'Transitions: ' + str(transitions)
    print 'Compares: ' + str(compares)


def mergesort(array, low, high):

    global compares
    global recursive_calls
    global transitions

    recursive_calls += 1

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

    flag = None

    for l in range(low, high+1):
        if d[k] <= b[i] and d[k] <= c[j]:
            compares += 2
            if flag != 'd':
                transitions += 1
                flag = 'd'
            array[l] = d[k]
            k += 1

        elif c[j] <= b[i] and c[j] <= d[k]:
            compares += 2
            if flag != 'c':
                transitions += 1
                flag = 'c'
            array[l] = c[j]
            j += 1
        else:
            compares += 2
            if flag != 'b':
                transitions += 1
                flag = 'b'
            array[l] = b[i]
            i += 1

if __name__ == '__main__':
    main(sys.argv[1])
