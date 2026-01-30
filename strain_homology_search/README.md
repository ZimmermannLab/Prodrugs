# Strain Homology Search
This directory contains scripts for downloading genomes of 69 panel strains [process_genomes.sh](https://github.com/ZimmermannLab/Prodrugs/blob/main/strain_homology_search/process_genomes.sh) and performing homology search [blastp.sh](https://github.com/ZimmermannLab/Prodrugs/blob/main/strain_homology_search/blastp.sh).

You can directly download the panel genomes with the link https://oc.embl.de/index.php/s/wfDbjy9ZYGbzuhN

## Overview
- `process_genomes.sh`  
  Pipeline to download genomes listed in `strainids.txt`, extract protein FASTA files, rename headers to include source accession, and concatenate processed FASTA files into a master FASTA (`mapping_69strains_genomicfp.fasta`).

- `blastp.sh`  
  Creates a BLAST database from the master FASTA and runs `blastp` with `bf2170.fasta` as the query. The script currently expects an NCBI BLAST+ distribution at `./ncbi-blast-2.16.0+`

- `strainids.txt`  
  Newline-separated list of NCBI assembly accessions used by `process_genomes.sh`.

- `bf2170.fasta`  
  Query protein FASTA used for the BLASTP search.

## Dependencies
- Conda (for the conda environment used in `process_genomes.sh`)  
  - The script activates a conda env named `ncbi_datasets` — ensure that env exists and contains the NCBI Datasets CLI.
- NCBI Datasets CLI (`datasets`) for downloading genomes (see https://www.ncbi.nlm.nih.gov/datasets/docs/)  
- unzip (to extract downloaded archives)
- NCBI BLAST+ (`makeblastdb`, `blastp`) for `blastp.sh` (tested/expected at `./ncbi-blast-2.16.0+`)
- bash (POSIX shell)

## Usage
1. Make scripts executable:
   ```bash
   chmod +x process_genomes.sh blastp.sh
   ```

2. Run the genome processing pipeline (this downloads assemblies listed in `strainids.txt`):
   ```bash
   # ensure conda env 'ncbi_datasets' is available and contains datasets CLI
   ./process_genomes.sh
   ```
   This produces per-genome processed FASTA files in the repository and concatenates them into:
   - `mapping_69strains_genomicfp.fasta`

3. Prepare/run BLAST (adjust BLAST+ path in `blastp.sh` if needed):
   ```bash
   ./blastp.sh
   ```
   Expected outputs:
   - BLAST database files (title `mapping69blastDB` in the script)
   - `bf2170blastp` (blast tabular output)

## Notes and tips
- `process_genomes.sh` renames each protein FASTA header to include the origin accession to make hits traceable to source genomes.
- `blastp.sh` currently references `mapping_69strains_genomicfp_ws.fasta` as the DB input. `process_genomes.sh` creates `mapping_69strains_genomicfp.fasta`.
- Adjust the BLAST+ binary path in `blastp.sh` if you have BLAST in your `$PATH` (e.g., replace `./ncbi-blast-2.16.0+/bin/blastp` with `blastp`).
- Downloads may require substantial disk space; run on a machine with sufficient storage and a stable internet connection.
- For reproducibility, note the author/date strings in the scripts (author: Resul Gökberk Elgin, 2025).

## **Contact**

If you use these scripts in your research, please cite:  
- Prodrugs [Ting-Hao Kuo et al., bioRxiv (2025)](https://www.biorxiv.org/content/10.64898/2025.12.09.692405v1)  
- O’Leary NA, Cox E, Holmes JB, Anderson WR, Falk R, Hem V, Tsuchiya MTN, Schuler GD, Zhang X, Torcivia J, Ketter A, Breen L, Cothran J, Bajwa H, Tinne J, Meric PA, Hlavina W, Schneider VA. [Exploring and retrieving sequence and metadata for species across the tree of life with NCBI Datasets.](https://www.nature.com/articles/s41597-024-03571-y) Sci Data. 2024 Jul 5;11(1):732. doi: 10.1038/s41597-024-03571-y. PMID: 38969627; PMCID: PMC11226681.
- Camacho C., Coulouris G., Avagyan V., Ma N., Papadopoulos J., Bealer K., Madden T.L. (2008) “BLAST+: architecture and applications.” BMC Bioinformatics 10:421. [PubMed](https://www.ncbi.nlm.nih.gov/pubmed/20003500?dopt=Citation)
  
---  
  
**## Contact**  
  
For questions or issues please contact: [tinghao.kuo@embl.de](mailto:tinghao.kuo@embl.de) and resul.elgin@embl.de, or submit an issue to the GitHub Repo.

