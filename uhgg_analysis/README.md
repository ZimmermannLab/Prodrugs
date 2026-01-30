# UHGG Analysis

This folder contains resources and scripts for the analysis of the Unified Human Gastrointestinal Genome (UHGG) dataset. It is organized into subdirectories that focus on different aspects of the analysis.

## Folder Structure

```
uhgg_analysis
│
├── phylogeny/
│   └── [Files related to phylogenetic analysis]
│
└── scripts/
    └── [Scripts for data processing and analysis]
```

### 1. `phylogeny`
This directory contains resources and files related to phylogenetic analysis of the UHGG dataset.

- Path: `uhgg_analysis/phylogeny`
- [Navigate to directory](https://github.com/ZimmermannLab/Prodrugs/tree/b849e5ae09217ce48890741a4443dfb7aae58f0b/uhgg_analysis/phylogeny)

### 2. `scripts`
The `scripts` directory includes scripts for data processing and analysis specific to UHGG analysis.

- Path: `uhgg_analysis/scripts`
- [Navigate to directory](https://github.com/ZimmermannLab/Prodrugs/tree/b849e5ae09217ce48890741a4443dfb7aae58f0b/uhgg_analysis/scripts)

---

## Usage

This repository provides resources and scripts for analyzing the Unified Human Gastrointestinal Genome (UHGG) dataset.

### IQ-TREE Phylogenetic Analysis
The IQ-TREE SLURM script performs large-scale phylogenetic tree construction using the MGnify `bac120_alignment.faa` dataset.

1. Downloads a precomputed [bac120_alignment.faa.gz](https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/human-gut/v2.0.2/phylogenies/bac120_alignment.faa.gz) file. The script can automatically download this file during execution.
2. Runs IQ-TREE version **3.0.1** as a SLURM job to perform phylogenetic analysis on the `bac120_alignment.faa` dataset.

#### Example:
Submit the SLURM batch job:
```bash
sbatch iqtree_bac120.sbatch
```
> **Note:** Modify the SLURM parameters in the script (e.g., `--time`, `--cpus-per-task`, `--mem`) according to your computational resources and job requirements.

#### Requirements:
- IQ-TREE installed (e.g., via Conda/Mamba, module system, or a local install). Ensure `iqtree` is available in your `PATH`.

- SLURM for job scheduling.

### Expected Outputs:
- Phylogenetic tree files (bootstrap-supported trees) in the `uhgg_bac120_tree/` directory.

---

### Subtree Extraction using R
The `uhgg_subtree_extraction.R` script performs phylogenetic analyses:
1. Reads a full phylogenetic tree in Newick format.
2. Identifies the Most Recent Common Ancestor (MRCA) based on the user-defined genome IDs.
3. Extracts the subtree and saves it as a Newick file.

#### Example:
```bash
Rscript uhgg_subtree_extraction.R
```

Input: `bac120_alignment.faa.treefile`  
Output: `uhgg_bacteroidota_subtree.nwk`

#### Requirements:
- **APE** version **5.8** in your R environment. The script will install it automatically if not found.

---

## Citation

If you use this code or data as part of your research, please cite the following:

1. **Prodrugs (Ting-Hao Kuo et al., bioRxiv, 2025)**
   - Preprint: Gut bacteria generate prodrugs in situ increasing systemic drug exposure.
   - DOI: [10.64898/2025.12.09.692405](https://doi.org/10.64898/2025.12.09.692405)
   - bioRxiv page: https://www.biorxiv.org/content/10.64898/2025.12.09.692405v1

2. **UHGG (Unified Human Gastrointestinal Genome catalog)**
   - Almeida, A., Nayfach, S., Boland, M. et al. *A unified catalog of 204,938 reference genomes from the human gut microbiome.* **Nature Biotechnology** 39, 105–114 (2021).
   - DOI: [10.1038/s41587-020-0603-3](https://doi.org/10.1038/s41587-020-0603-3)

3. **IQ-TREE**
   - Minh, B.Q., Schmidt, H.A., Chernomor, O. et al. *IQ-TREE 2: New Models and Efficient Methods for Phylogenetic Inference in the Genomic Era.* **Molecular Biology and Evolution** 37(5), 1530–1534 (2020).
     - DOI: [10.1093/molbev/msaa015](https://doi.org/10.1093/molbev/msaa015)
   - (If using IQ-TREE 3 features / version 3.x) Wong, T.K.F. et al. *IQ-TREE 3: Phylogenomic Inference Software using Complex Evolutionary Models* (2025).
     - DOI: [10.32942/X2P62N](https://doi.org/10.32942/X2P62N)
   - Website: https://iqtree.github.io/

4. **APE (Analysis of Phylogenetics and Evolution)**
   - Paradis, E. and Schliep, K. *ape 5.0: an environment for modern phylogenetics and evolutionary analyses in R.* **Bioinformatics** 35(3), 526–528 (2019).
   - DOI: [10.1093/bioinformatics/bty633](https://doi.org/10.1093/bioinformatics/bty633)
   - CRAN: https://cran.r-project.org/package=ape

---

For further questions or details, refer to the repository's main documentation or get in touch with the Zimmermann Lab team.

---
