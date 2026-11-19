#!/bin/bash
# TP7 - script17.sh
# Create the Project_ibbc directories without changing existing contents.
set -euo pipefail

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project1="Project_ibbc"
project_dir="$working_dir/$project1"

if [[ ! -d "$working_dir" ]]; then
  echo "ERROR: Working directory not found: $working_dir" >&2
  exit 1
fi

for directory in "$project_dir" "$project_dir/1_raw_data" "$project_dir/2_metadata"; do
  if [[ -d "$directory" ]]; then
    echo "The directory already exists: $directory"
  elif [[ -e "$directory" ]]; then
    echo "ERROR: A non-directory file exists at: $directory" >&2
    exit 1
  else
    mkdir "$directory"
    echo "Created directory: $directory"
  fi
done

echo "Done."
