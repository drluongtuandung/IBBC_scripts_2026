# IBBC – Bash Scripting and Git Exercises

Practical exercises for Introduction to Bioinformatics and Computational Biology (2026/2027).

This repository contains Bash scripts developed during TP7, TP8a, TP8b, and the Scripting Evaluation, together with the Git exercises from TP10.

## Repository Structure

| Directory | Contents |
|---|---|
| `TP7_Bash_basics/` | Scripts 1–17: introductory Bash exercises |
| `TP8a_Bash_scripting/` | Scripts 18–30: Bash scripting exercises |
| `TP8b_Bash_scripting/` | Scripts 31–36: further Bash exercises |
| `Scripting_Evaluation/` | Evaluation scripts and FASTQ quality-control workflow |
| `Project_ibbc/` | Small example files used by the exercises |

The repository root also contains `samples.txt` and `samplelist2.txt`, used by scripts that read sample lists.

The root-level `script31.sh`, `script32.sh`, and `script33.sh` were used for the TP10 Git exercises. Their commit history demonstrates modifications, branching, and merging. The TP8b directory retains separate copies of these exercises.

## Requirements

- Bash
- Standard Unix command-line utilities
- `tar` for the FASTA compression exercise
- `fastp` for the paired-end FASTQ quality-control evaluation

The introductory Bash exercises were developed on macOS. The Scripting Evaluation was tested in a Linux environment on the Loki cluster.

## Running the Bash Exercises

Clone the repository:

```bash
git clone https://github.com/drluongtuandung/IBBC_scripts_2026.git
cd IBBC_scripts_2026
```

Examples:

```bash
bash TP7_Bash_basics/script14.sh
bash TP7_Bash_basics/script17.sh
bash TP8a_Bash_scripting/script22.sh
bash TP8a_Bash_scripting/script23.sh
bash TP8b_Bash_scripting/script35.sh
```

Some scripts check whether files exist, including files intentionally absent from the example dataset.

Other scripts create directories, files, or compressed archives. Review their contents before running them.

## Example Data

`Project_ibbc/1_raw_data/` contains two small illustrative FASTA files and an example text file.

`Project_ibbc/2_metadata/` contains an example metadata text file.

These are teaching examples, not real sequencing datasets.

## Scripting Evaluation

The evaluation consists of:

1. `evaluation1.sh`: creation of an analysis directory structure.
2. `evaluation2.sh`: initial configuration for paired-end FASTQ quality control.
3. `evaluation2_workflow.sh`: operational workflow using fastp.
4. `evaluation3_qc_summary.sh`: aggregation of fastp quality-control results.

The workflow uses a project directory, by default:

```bash
$HOME/IBBC_analysis
```

The fastp executable defaults to:

```bash
$HOME/miniconda3/envs/tools_qc/bin/fastp
```

The operational workflow supports environment-variable configuration, including `PROJECT`, `FASTP`, and `MANIFEST`.

FASTQ input files and a corresponding manifest must be supplied separately. The complete sequencing datasets are not included in this repository.

The workflow was tested with a small demonstration dataset. A separate manifest-based dry run was used to assess scalability without processing 101 independent datasets.

## Notes

- Scripts are retained as individual coursework exercises.
- Some exercises intentionally test missing files.
- Syntax validation does not guarantee successful execution in every environment.
- The original exercise scripts are preserved separately from this repository.
