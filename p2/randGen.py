import sys
import random

def main( nums, range ):
  for i in range(0,int(nums)):
    print random.randint(1,int(range))


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])