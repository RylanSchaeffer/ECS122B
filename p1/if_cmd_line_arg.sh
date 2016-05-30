#!/bin/bash

# $1 is the first command line argument
# The [ ] evaluates a condition
# Semicolon ends a current line of the shell script and begins a new one
if [ "$1" != "" ] && [ "$2" != "" ]; then
    # if the first & second cmd line arg exist, print
    echo "$1 and $2"
elif [ "$1" != "" ]; then
    echo "$1"
else
    echo "No command line arguments..."
fi
