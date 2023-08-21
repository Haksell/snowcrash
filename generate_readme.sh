#!/bin/bash

echo -n "" > README.md
for i in $(seq -w 00 14); do
    # Adjust the image paths to be relative to the root directory
    sed "s|!\[Alt text\](|&level${i}/resources/|g" level${i}/resources/writeup.md >> README.md
    echo -e -n "\n\n" >> README.md
done
