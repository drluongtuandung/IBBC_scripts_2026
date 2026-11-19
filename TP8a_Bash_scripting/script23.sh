
#!/bin/bash

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Project_ibbc"
filename="file1.txt"

function_name() {
    if [ -f "$basedir/2_metadata/$filename" ]
    then
        echo "the file exists"
    else
        echo "the file do not exist"
    fi
}

function_name
