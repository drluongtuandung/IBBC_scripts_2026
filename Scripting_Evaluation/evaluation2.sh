
#!/usr/bin/env bash

set -euo pipefail

# Introduction to Bioinformatics - Evaluation 2
# Paired-end FASTQ processing with fastp

# Project directories on Loki
PROJECT="$HOME/IBBC_analysis"
RAW_DIR="$PROJECT/1_raw_data"
METADATA_DIR="$PROJECT/2_metadata"
RESULTS_DIR="$PROJECT/4_results"
LOG_DIR="$PROJECT/6_logs"

# fastp executable in the tools_qc environment
FASTP="$HOME/miniconda3/envs/tools_qc/bin/fastp"

# Default processing parameters
THREADS=2
QUALITY=20
MIN_LENGTH=50

# Sample manifest
MANIFEST="$METADATA_DIR/fastq_manifest.tsv"
