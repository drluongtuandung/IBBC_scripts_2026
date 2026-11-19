
#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$script_dir/script12.sh" ]; then
    echo "The file exists"
else
    echo "The file does not exist"
fi
