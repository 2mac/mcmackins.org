#!/bin/sh

# Converts all markdown to hypertext markup

for OUTPUT in $(find . -type f -name '*.md' -exec echo {} \;)
do
    python3 convert.py ${OUTPUT%.md}
done

