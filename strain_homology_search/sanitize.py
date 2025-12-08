######################################################################
# Script to remove whitespaces in the fasta headers to avoid truncation
# in the alignment results.
# Requires the installation of Bio library in python. Please see the
# installation instructions at https://pypi.org/project/bio/
######################################################################
By Resul Gökberk Elgin (2025)
######################################################################

import os
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def ws_comma_removal(input_fasta, output_fasta_ws):
    with open(output_fasta_ws, "w") as output_handle:
        for record in SeqIO.parse(input_fasta, "fasta"):
            record.description = record.description.replace(" ", "_").replace(",", "")
            record.id = record.description.split()[0]  # Ensures ID consistency
            SeqIO.write(record, output_handle, "fasta")

        
def auto_generate_filenames(input_fasta):
    base, ext = os.path.splitext(input_fasta)
    output_fasta_clean = f"{base}_ws{ext}"
    output_fasta_filtered = f"{base}_wslen{ext}"
    return output_fasta_clean, output_fasta_filtered

def main(input_fasta):
    output_fasta_clean, output_fasta_filtered = auto_generate_filenames(input_fasta)
    ws_comma_removal(input_fasta, output_fasta_clean)
    
# File paths
input_fasta = "mapping_69strains_genomicfp.fasta"

main(input_fasta)