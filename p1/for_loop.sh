#!/bin/bash

# {1..10} is the range of x, inclusive
# x in is part of a "for each" - it
for x in {1..4}; do
    echo "$x"
done

for script in $(ls *.sh); do
    echo "$script"
done
