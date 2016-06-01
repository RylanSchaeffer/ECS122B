import sys
import random


def main(nums, domain):

    for iter in range(int(nums)):
        sys.stdout.write(str(random.randint(1, int(domain))) + ' ')


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])