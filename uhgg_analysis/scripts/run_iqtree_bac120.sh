#!/bin/bash

###############################################
# IQ-TREE phylogeny build for UHGG bac120
# Author: Anoop Singh (EMBL Heidelberg)
#
# Previous run required ~9.5 days (~228 hours)
# Updated runtime request: 12 days
###############################################

#SBATCH --job-name=iqtree_bac120
#SBATCH --time=12-00:00:00
#SBATCH --qos=normal
#SBATCH -p htc-el8

# Resources
#SBATCH -N 1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G

# Log files
#SBATCH -e sbatch_logs/%x_%j_err.txt
#SBATCH -o sbatch_logs/%x_%j_out.txt

###############################################
# Environment setup
###############################################

# Create log and output directories
mkdir -p sbatch_logs
mkdir -p uhgg_bac120_tree

echo "Job $SLURM_JOB_NAME ($SLURM_JOBID) is running on node: $(hostname -s)"
echo "Starting at: $(date)"
echo "Script written by Anoop Singh (EMBL Heidelberg)"

# Activate conda environment
echo "Activating IQ-TREE conda environment..."
source /home/asingh/miniforge3/etc/profile.d/conda.sh
conda activate /home/asingh/miniforge3/envs/iqtree3

# Move into output directory
cd uhgg_bac120_tree

###############################################
# Download MGnify bac120 alignment
###############################################

URL="https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/human-gut/v2.0.2/phylogenies/bac120_alignment.faa.gz"
FILE="bac120_alignment.faa.gz"

if [[ ! -f "$FILE" ]]; then
    echo "Downloading MGnify bac120 alignment..."
    wget -q "$URL"
else
    echo "Download skipped — file already exists: $FILE"
fi

###############################################
# Decompress alignment
###############################################

if [[ ! -f "bac120_alignment.faa" ]]; then
    echo "Unzipping alignment..."
    gunzip -f "$FILE"
else
    echo "Unzip skipped — alignment already uncompressed."
fi

###############################################
# Run IQ-TREE analysis
###############################################

echo "Starting IQ-TREE analysis..."
iqtree -s bac120_alignment.faa -m MFP -B 1000 -T Auto 
    

echo "IQ-TREE analysis completed successfully."
echo "Output directory: $(pwd)"
echo "Completed at: $(date)"
