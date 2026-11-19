#!/bin/bash

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
directory=mkdir

if [ -d "$working_dir/dir1" ]; then
    echo "The directory dir1 exists"
else
    echo "Creating directory dir1"
    "$directory" "$working_dir/dir1"
fi
