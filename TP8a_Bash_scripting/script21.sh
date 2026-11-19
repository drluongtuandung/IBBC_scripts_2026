#!/bin/bash
# TP8a - script21.sh
# Compress FASTA files from Project_ibbc/1_raw_data using a for loop.
set -euo pipefail

working_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
data_dir="$working_dir/Project_ibbc/1_raw_data"

if [[ ! -d "$data_dir" ]]; then
  echo "ERROR: Data directory not found: $data_dir" >&2
  exit 1
fi

shopt -s nullglob
fasta_files=("$data_dir"/*.fasta)
if (( ${#fasta_files[@]} == 0 )); then
  echo "No .fasta files found in $data_dir"
  echo "The TP8a exercise asks you to create two dummy FASTA files first."
  exit 1
fi

for file in "${fasta_files[@]}"; do
  archive="${file}.tar.gz"
  if [[ -e "$archive" ]]; then
    echo "Skipping existing archive: $archive"
    continue
  fi
  tar -czvf "$archive" -C "$data_dir" "$(basename "$file")"
  echo "Created: $archive"
done

echo "done"
