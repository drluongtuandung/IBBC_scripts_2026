
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "This script requires exactly one argument"
    echo "Please try again"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

lines=$(ls -lh "$1" | wc -l)

echo "You have $((lines - 1)) objects in the $1 directory"
