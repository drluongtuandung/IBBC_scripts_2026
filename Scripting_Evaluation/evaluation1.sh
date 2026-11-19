
#!/bin/bash

set -euo pipefail

# Directory structure for sequencing data analysis.
# The script uses the home directory of the
# user running it on the server.

project="$HOME/IBBC_analysis"

directories=(
    "1_raw_data"
    "2_metadata"
    "3_reference"
    "4_results"
    "5_scripts"
    "6_logs"
    "7_tmp"
)

# Preview mode: do not create any directories.
if [[ "${1:-}" == "--dry-run" ]]; then
    echo "Project directory: $project"

    for dir in "${directories[@]}"; do
        echo "Would create: $project/$dir"
    done

    exit 0
fi

# Create the main project directory.
mkdir -p "$project"

# Create the subdirectories.
for dir in "${directories[@]}"; do
    mkdir -p "$project/$dir"
    echo "Checked: $project/$dir"
done

echo "Directory structure created successfully."
