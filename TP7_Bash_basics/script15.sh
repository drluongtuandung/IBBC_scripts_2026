#!/bin/bash

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
runtouch=$(command -v touch)

if [ -f "$working_dir/file1.txt" ]; then
    echo "The file file1.txt exists"
else
    echo "Creating file1.txt"
    "$runtouch" "$working_dir/file1.txt"
fi
