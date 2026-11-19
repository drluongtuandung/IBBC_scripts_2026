
#!/bin/bash

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Project_ibbc/1_raw_data"

for file in "$working_dir"/*.fasta; do
    echo "$file"
done
