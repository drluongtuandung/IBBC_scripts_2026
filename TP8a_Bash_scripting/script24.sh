
#!/bin/bash

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Project_ibbc"
filename="sample1_R1.fasta"

check_file() {
    if [ -f "$basedir/1_raw_data/$filename" ]
    then
        echo "the file exists"
    else
        echo "the file do not exist"
    fi
}

check_file
