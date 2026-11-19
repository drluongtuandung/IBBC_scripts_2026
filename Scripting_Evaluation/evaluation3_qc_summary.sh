
#!/usr/bin/env bash

set -euo pipefail

# Introduction to Bioinformatics - Evaluation 3
# Summarize fastp QC reports across multiple runs.

PROJECT="${PROJECT:-$HOME/IBBC_analysis}"

if [ "$#" -eq 0 ]; then
    echo "Usage: bash $0 RUN_ID [RUN_ID ...]" >&2
    exit 1
fi

python3 - "$PROJECT" "$@" <<'PY'
import json
import sys
from pathlib import Path

project = Path(sys.argv[1])
run_ids = sys.argv[2:]

print(
    "run_id\tsample_id\treads_before\treads_after"
    "\tretained_pct\tq30_after_pct"
)

for run_id in run_ids:
    result_dir = project / "4_results" / run_id

    if not result_dir.is_dir():
        sys.exit(f"ERROR: Directory not found: {result_dir}")

    reports = sorted(result_dir.glob("*.json"))

    if not reports:
        sys.exit(f"ERROR: No JSON reports in {result_dir}")

    for report in reports:
        with report.open() as f:
            data = json.load(f)

        before = data["summary"]["before_filtering"]
        after = data["summary"]["after_filtering"]

        reads_before = before["total_reads"]
        reads_after = after["total_reads"]

        retained_pct = (
            100 * reads_after / reads_before
            if reads_before > 0 else 0
        )

        q30_pct = after["q30_rate"] * 100

        print(
            f"{run_id}\t{report.stem}\t"
            f"{reads_before}\t{reads_after}\t"
            f"{retained_pct:.2f}\t{q30_pct:.2f}"
        )
PY
