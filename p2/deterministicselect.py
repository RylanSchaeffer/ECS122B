# deterministic select kth element of array
# based on pseudocode at Wikipedia: https://en.wikipedia.org/wiki/Median_of_medians

import math
import statistics
import sys

def main(filename, k):

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    deterministicSelect(array, 0, len(array) - 1, k)


def deterministicSelect(array, left, right, k):

    if left == right:
        return left

    while True:

        pivotIndex = pivot(array, left, right)

        pivotIndex = partition(array, left, right, pivotIndex)

        if pivotIndex == k:
            return k
        elif k < pivotIndex:
            right = pivotIndex - 1
        else:
            left = pivotIndex + 1


def partition(array, left, right, pivotIndex):

    pivotValue = array[pivotIndex]

    array[pivotIndex], array[right] = array[right], array[pivotIndex]

    storeIndex = left

    for iter in range(left, right):

        if array[iter] < pivotValue:
            array[storeIndex], array[iter] = array[iter], array[storeIndex]
            storeIndex += 1

    array[right], array[storeIndex] = array[storeIndex], array[right]

    return storeIndex


def pivot(array, left, right):

    # if 5 or fewer elements, return median
    if right - left < 5:
        return statistics.median_low(array[left:(right+1)])

    for i in range(left, right, 5):

        subRight = i + 4
        if subRight > right:
            subRight = right

        median5 = int(statistics.median_low(array[i:(subRight+1)]))

        array[median5], array[left + int(math.floor((i-left)/5))] = \
            array[left + int(math.floor((i-left)/5))], array[median5]

    return deterministicSelect(array, left, left + int(math.ceil((right - left) / 5)) - 1, left + (right-left)/10)


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])