#!/bin/bash

echo -n "" > README.md
for i in $(seq -w 00 14); do
    cat level${i}/resources/writeup.md >> README.md
    echo -e -n "\n\n" >> README.md
done
