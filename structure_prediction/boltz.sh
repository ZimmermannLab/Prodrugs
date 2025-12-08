######################################################################
# This directory contains the inputs and associated script to 
# reproduce the structure prediction analysis using Boltzv0.4.1
# in figure S3D.
######################################################################
# Viewers are referred to installation instructions from Boltz
# developers at https://github.com/jwohlwend/boltz
######################################################################
# The tool requires access to powerful GPUs which is the reason we
# prompted our High Computing Cluster (HPC) at EMBL to run the script
######################################################################
# by Resul Gökberk Elgin (2025)
######################################################################


#!/bin/bash
#SBATCH -J envision_bezafibrate # Name of your job
#SBATCH -p gpu-el8 -C gpu=A100 --gpus 1 --cpus-per-gpu 64 --mem-per-gpu 51428 # Requested node and GPU from the HPC server
#SBATCH -t 2:00:00                  # runtime limit (D-HH:MM:SS)
#SBATCH -o slurm.%N.%j.out          # STDOUT
#SBATCH -e slurm.%N.%j.err          # STDERR
#SBATCH --mail-type=BEGIN,END,FAIL        # notifications for job done & fails

# Load the Miniforge3 for accessing conda environments.
module load Miniforge3

# Guard your conda env.
source <(conda shell.bash hook)

# Activate boltz1 env.
conda activate boltzv041

# Execute the prediction
boltz predict input --out_dir output --use_msa_server --recycling_steps 10 --sampling_steps 200 --diffusion_samples 5
