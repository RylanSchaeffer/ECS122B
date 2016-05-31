# quickselect kth element of array
# based on pseudocode at Wikipedia: https://en.wikipedia.org/wiki/Quickselect


import sys

def main(filename, k):

    file = open(filename, 'r')
    array = [int(ele) for ele in file.readline().split()]
    file.close()

    quickSelect(array, 0, len(array) - 1, int(k))


def quickSelect(array, left, right, k):

    while True:

        if left == right:
            return array[left]

        pivotIndex = (left + right)/2

        pivotIndex = partition(array, left, right, pivotIndex)

        if k == pivotIndex:
            return array[k]
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


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])