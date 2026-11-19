
#!/bin/bash

number=1

while [ $number -ge 1 ] && [ $number -le 50 ]
do
    echo "number= $number"
    number=$((number + 3))
    sleep 0.5
done
