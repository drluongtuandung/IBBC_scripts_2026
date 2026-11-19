
#!/bin/bash

echo "Choose the trimming software"
echo "1 Trimmomatic"
echo "2 fastp"
echo "3 cutadapt"

read apptorun

case $apptorun in
    1)
        echo "Trimmomatic is easy to use"
        ;;
    2)
        echo "fastp is the most complete"
        ;;
    3)
        echo "cutadapt is very popular"
        ;;
    *)
        echo "you can only choose one of these"
        ;;
esac
