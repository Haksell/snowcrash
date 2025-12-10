#!/bin/bash

FILE=README.md

echo "# Snowcrash" > $FILE
echo >> $FILE
for i in $(seq -w 00 14); do
    # Adjust the image paths to be relative to the root directory
    sed "s|!\[Alt text\](|&level${i}/resources/|g" level${i}/resources/writeup.md >> $FILE
    echo -e -n "\n\n" >> $FILE
done
