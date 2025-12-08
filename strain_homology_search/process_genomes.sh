######################################################################
# Pipeline to reproduce the 76 strains homology search results in 
# Figure 2D and SI Table 7. 
# The pipeline downloads the genomes from strainids.txt file using
# NCBI commandline tools (Please see installation instructions at
# https://www.ncbi.nlm.nih.gov/datasets/docs/v2/command-line-tools/download-and-install)
# Then, fingerprints the proteins in the fasta file by the origin of 
# genomes and concatenates the protein fasta files in one master fasta.
######################################################################
By Resul Gökberk Elgin (2025)
######################################################################

#!/bin/bash

# Load the conda env.
module load Miniforge3
source <(conda shell.bash hook)
conda activate ncbi_datasets 

# Read the file and execute datasets download
while IFS= read LINE; do datasets download genome accession "$LINE" --include protein --filename "$LINE.zip"; done < strainids.txt

unzip "*.zip"

for file in ncbi_dataset/data/*/protein.faa
do
directory_name=$(dirname $file)
accession=$(basename $directory_name)
mv "${file}" "${directory_name}/${accession}_$(basename $file)"
done

mkdir -p strains

mv *.zip md5sum.txt README.md strainids.txt strains

mkdir -p fastas

find . -name '*_protein.faa' -exec cp {} fastas \;

# Loop through all FASTA files in the fastas directory
for input_file in fastas/*.faa; do
    output_file="${input_file%_protein.faa}_genomicfp.fasta"

    # Temporary variables
    header=""
    sequence=""

    # Read the FASTA file line by line
    while read -r line; do
        if [[ $line == ">"* ]]; then
            # Process the previous sequence if it exists
            if [[ -n $header ]]; then
                # Modify the header
                modified_header="${header:1}|${input_file%_protein.faa}"
                echo ">$modified_header" >> "$output_file"
                echo "$sequence" >> "$output_file"
            fi
            # Start a new sequence
            header=$line
            sequence=""
        else
            # Concatenate the sequence lines
            sequence+=$line
        fi
    done < "$input_file"

    # Process the last sequence
    if [[ -n $header ]]; then
        modified_header="${header:1}|${input_file%_protein.faa}"
        echo ">$modified_header" >> "$output_file"
        echo "$sequence" >> "$output_file"
    fi

done

# Concatenate all the processed fasta sequences to a master fasta for the dataset.
cat fastas/*.fasta > mapping_69strains_genomicfp.fasta
