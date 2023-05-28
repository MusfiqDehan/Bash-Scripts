#!/bin/bash

# Check if a file name is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Sort the file contents
sorted_file="${filename}.sorted"
sort "$filename" >"$sorted_file"

echo "Sorted contents have been saved to: $sorted_file"

