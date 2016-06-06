import sys
import random


def main(nums, domain):

    file = open('randNums.txt', 'w')

    for iter in range(int(nums)):
        file.write(str(random.randint(1, int(domain))) + ' ')

    file.close()


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])