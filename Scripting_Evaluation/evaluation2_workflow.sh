#!/usr/bin/env bash
set -euo pipefail

PROJECT="${PROJECT:-$HOME/IBBC_analysis}"
RAW_DIR="$PROJECT/1_raw_data"
METADATA_DIR="$PROJECT/2_metadata"
RESULTS_DIR="$PROJECT/4_results"
LOG_DIR="$PROJECT/6_logs"
FASTP="${FASTP:-$HOME/miniconda3/envs/tools_qc/bin/fastp}"
THREADS="${THREADS:-2}"
QUALITY="${QUALITY:-20}"
MIN_LENGTH="${MIN_LENGTH:-50}"
MANIFEST="${MANIFEST:-$METADATA_DIR/fastq_manifest.tsv}"
RUN_ID="${RUN_ID:-demo_trial_01}"

if [[ "${1:-}" != "" && "${1:-}" != "--dry-run" ]]; then
    echo "Usage: bash evaluation2.sh [--dry-run]" >&2
    exit 2
fi
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

[[ "$RUN_ID" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]] || { echo "Invalid RUN_ID" >&2; exit 2; }
[[ -x "$FASTP" ]] || { echo "fastp not executable: $FASTP" >&2; exit 1; }
[[ -f "$MANIFEST" ]] || { echo "Missing manifest: $MANIFEST" >&2; exit 1; }
[[ "$THREADS" =~ ^[1-9][0-9]*$ && "$QUALITY" =~ ^[0-9]+$ && "$MIN_LENGTH" =~ ^[1-9][0-9]*$ ]] || { echo "Invalid numeric settings" >&2; exit 2; }
(( QUALITY <= 40 )) || { echo "QUALITY must be at most 40" >&2; exit 2; }

samples=()
r1_files=()
r2_files=()
line=0
while IFS=$'\t' read -r sample r1 r2 || [[ -n "$sample$r1$r2" ]]; do
    line=$((line + 1))
    r2="${r2%$'\r'}"
    if [[ "$line" -eq 1 ]]; then
        [[ "$sample" == "sample_id" && "$r1" == "R1" && "$r2" == "R2" ]] || { echo "Incorrect manifest header" >&2; exit 1; }
        continue
    fi
    [[ -z "$sample$r1$r2" ]] && continue
    [[ "$sample" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]] || { echo "Invalid sample ID on line $line" >&2; exit 1; }
    [[ -f "$r1" && -f "$r2" && "$r1" != "$r2" ]] || { echo "Invalid FASTQ inputs on line $line" >&2; exit 1; }
    for old in "${samples[@]+"${samples[@]}"}"; do
        [[ "$sample" != "$old" ]] || { echo "Duplicate sample ID: $sample" >&2; exit 1; }
    done
    samples+=("$sample")
    r1_files+=("$r1")
    r2_files+=("$r2")
done < "$MANIFEST"

(( ${#samples[@]} > 0 )) || { echo "No samples in manifest" >&2; exit 1; }
run_dir="$RESULTS_DIR/$RUN_ID"
run_logs="$LOG_DIR/$RUN_ID"

if (( DRY_RUN == 0 )); then
    [[ ! -e "$run_dir" && ! -e "$run_logs" ]] || { echo "Run ID already exists; choose a new RUN_ID" >&2; exit 1; }
    mkdir "$run_dir" "$run_logs"
    printf 'sample_id\tstatus\texit_code\n' > "$run_logs/status.tsv"
    { echo "fastp: $($FASTP --version 2>&1)"; printf 'threads=%s quality=%s min_length=%s\n' "$THREADS" "$QUALITY" "$MIN_LENGTH"; printf 'manifest=%s\n' "$MANIFEST"; } > "$run_logs/settings.txt"
fi

for idx in "${!samples[@]}"; do
    sample="${samples[$idx]}"
    cmd=("$FASTP" --in1 "${r1_files[$idx]}" --in2 "${r2_files[$idx]}"
      --out1 "$run_dir/${sample}_R1.fastq.gz" --out2 "$run_dir/${sample}_R2.fastq.gz"
      --qualified_quality_phred "$QUALITY" --length_required "$MIN_LENGTH"
      --thread "$THREADS" --html "$run_dir/${sample}.html" --json "$run_dir/${sample}.json")
    if (( DRY_RUN )); then
        printf 'DRY RUN [%s]: ' "$sample"
        printf '%q ' "${cmd[@]}"
        printf '\n'
    else
        printf '%q ' "${cmd[@]}" > "$run_logs/${sample}.command.txt"
        printf '\n' >> "$run_logs/${sample}.command.txt"
        if "${cmd[@]}" > "$run_logs/${sample}.stdout.log" 2> "$run_logs/${sample}.stderr.log"; then
            printf '%s\tOK\t0\n' "$sample" >> "$run_logs/status.tsv"
        else
            code=$?
            printf '%s\tFAILED\t%s\n' "$sample" "$code" >> "$run_logs/status.tsv"
            echo "Failed sample: $sample (exit $code)" >&2
            exit "$code"
        fi
    fi
done
printf 'Validated %s sample(s). Dry-run=%s\n' "${#samples[@]}" "$DRY_RUN"
