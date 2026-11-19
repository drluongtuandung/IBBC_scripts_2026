
#!/bin/bash

# Check number of arguments
if [ $# -ne 2 ]; then
    echo "Error: Please provide exactly two arguments"
    exit 1
fi

# Store arguments
dir1="$1"
dir2="$2"

# Check directories
if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
    echo "Error: One or both directories do not exist"
    exit 1
fi

# Count objects
lines1=$(ls -lh "$dir1" | wc -l)
lines2=$(ls -lh "$dir2" | wc -l)

count1=$((lines1 - 1))
count2=$((lines2 - 1))

# Print results
echo "First directory: $dir1"
echo "Number of objects: $count1"

echo "Second directory: $dir2"
echo "Number of objects: $count2"

echo "Total: $((count1 + count2))"
