
#!/bin/bash

Project="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Project_ibbc/"
working_dir=1_raw_data/
samplename=sample1
suffixR1=_R1.fasta
suffixR2=_R2.fasta

check_file() {
    if [ -f "$Project$working_dir$samplename$suffixR1" ]
    then
        echo "the file exists"
    else
        echo "the file do not exist"
    fi
}

check_file
