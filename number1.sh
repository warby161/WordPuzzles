#!/bin/bash

read -p "Enter file name: " file
read -p "Enter search pattern: " pattern

if [ -f "$file" ]
then
    result=$(grep -i "$pattern" "$file")
    echo "$result"
fi
