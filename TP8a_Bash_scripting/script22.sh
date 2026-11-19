
#!/bin/bash

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function function_name() {
    if [ -f "$working_dir/Project_ibbc/1_raw_data/file2.txt" ]
    then
        echo "the file exists"
    else
        echo "the file do not exist"
    fi
}

function_name
