######################################################################
# Script to detect putative bf2170 isofunctional hits in the 76 strain
# homology search method.
# Script requires the installation of NCBI blastp tool. Please see the
# installation instructions at https://www.ncbi.nlm.nih.gov/books/NBK569861/
######################################################################
By Resul Gökberk Elgin (2025)
######################################################################

#!/bin/bash

./ncbi-blast-2.16.0+/bin/makeblastdb -in mapping_69strains_genomicfp_ws.fasta -title mapping69blastDB -dbtype prot

./ncbi-blast-2.16.0+/bin/blastp -db mapping_69strains_genomicfp_ws.fasta -query bf2170.fasta -out bf2170blastp -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" -qcov_hsp_perc 50
