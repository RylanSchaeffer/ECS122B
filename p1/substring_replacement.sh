#!/bin/bash

# Substring replacement: ${stringvar/substring/replacement}
x="Hello World"
y=${x/Hello/Goodbye Cruel}
echo "$y"

# * matches any character
# b/c we ended with bye, replace the entire string with bye
# That is, *bye* matches all of y
z=${y/*bye*/bye}
echo "First: $z"

z=${y/*bye/bye}
echo "Second: $z"

