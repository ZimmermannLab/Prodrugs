# Cheminformatics Analysis

This directory contains scripts for chemical classification [classification.r](https://github.com/ZimmermannLab/Prodrugs/blob/main/carboxyl_drug_screen/classification.r) and UMAP-based visualization of carboxyl-containing drug compounds against the small molecules in DrugBank database [DrugBank.ipynb](https://github.com/ZimmermannLab/Prodrugs/blob/main/carboxyl_drug_screen/DrugBank.ipynb).

## Overview

- **DrugBank.ipynb**: Python notebook for UMAP projection, chemical fingerprinting, and DrugBank metadata extraction
- **classification.r**: R script for chemical classification using ClassyFire and sunburst visualization

---

## 1. Software Dependencies used in this study

### DrugBank.ipynb (Python/ Jupyter Notebook)
- **Python**: 3.10
- **Required packages**:
  - `pandas` (2.3.3)
  - `numpy` (2.2.6)
  - `rdkit` (2025.9.1)
  - `umap-learn` (0.5.9)
  - `matplotlib` (3.10.7)
  - `seaborn` (0.13.2)
  - `requests` (2.32.5)

### classification.r (R)
- **R**: 4.4.1 
- **Required packages**:
  - `classyfireR` (from GitHub: aberHRML/classyfireR)
  - `dplyr` (1.1.4)
  - `readr` (2.1.6)
  - `plotly` (4.11.0)
  - `stringr` (1.6.0)
  - `purrr` (1.2.1)

### OS Compatibility
- **macOS**: 10.15+ (Catalina or later)
- **Linux**: Ubuntu 20.04+, CentOS 8+
- **Windows**: 10 or later

### Additional Requirements
- **DrugBank.v5_1_13 XML/CSV**: 
Academic License is free and available for researchers once their eligibility criteria is approved by the DrugBank Team. The useful categories from the approved downloaded XML file are extracted into a CSV file for easier data usage within this notebook. Please refer to the notebook [parse.ipynb](https://github.com/dhimmel/drugbank/blob/gh-pages/parse.ipynb) by [Daniel Himmelstein](https://github.com/dhimmel) to parse the XML file after acquiring the usage licence.
- **Internet connection**: Required for ClassyFire API calls and PubChem lookups

---

## 2. Installation Guide

### Python Environment Setup

```bash
# Create a virtual environment
python3 -m venv prodrug_env
source prodrug_env/bin/activate  # On Windows: prodrug_env\Scripts\activate

# Install dependencies
pip install pandas numpy rdkit matplotlib seaborn umap-learn requests
```

### R Environment Setup

```r
# Install CRAN packages
install.packages(c("dplyr", "readr", "plotly", "stringr", "purrr"))

# Install classyfireR from GitHub
install.packages("remotes")
remotes::install_github('aberHRML/classyfireR')
```
---

## 3. Instructions to Execute Python and R scripts

### DrugBank.ipynb 

**Input files**:
- Main dataset: `SI_Table20_COOHdrug_forZM.csv` or `TK001D6_COOH_record_20250103_withMethylSMILES_cut.csv`
- DrugBank CSV: `Drugbank/v5_1_13/FullDrugBank_XMLtoCSVv5_1_13.csv` (requires licence; see above to access DrugBank)

**Main Steps**:

- Import libraries and define SMILES cleaning function to remove salts
- Load your carboxyl drug dataset with clean SMILES
- Load and clean DrugBank dataset
- Generate molecular fingerprints for both datasets
- Create UMAP projection and visualization of the carboxyl drug data over the DrugBank database
- Extract DrugBank metadata via CAS, PubChem ID, and InChIKey matching to provide identifiers

**Outputs**:
   - UMAP plot: `umap_compact_plot2_SI_map.pdf`
   - Annotated identifier dataset: `TK001D6_COOH_record_20250103_withMethylSMILES_DrugBank.csv`

### classification.r Workflow

**Input files**:
- Upload CSV file with compound data containing atleast the following columns: `Name`, `InChIKey`

**Main Steps**:
- Ensure your CSV contains `Name` and `InChIKey` columns
- Use classyfireR to extract assign classification
- Extract inchikey, kingdom, superclass, class and subclass from the classification results and save it as a dataframe
- Use the final dataframe to generate input dataframe consisting of characters (all names of the kingdom, superclass, class, and subclass), values (occurence of each classification category) and parents (parent of each category)
- Use the new input dataframe to generate sunburst plots

**Outputs**:
   - `classification_list_pests.rds`: Raw ClassyFire classification objects
   - `prodrugs_Classification.csv`: Tabular classification data
   - Interactive sunburst plot

---

## 4. Expected Run Time
Th expected runtime depends on number of compounds in your input data
- PubChem API calls are rate-limited (0.5s delay per compound)
- ~1-3 seconds per compound for ClassyFire API


## Possible Troubleshooting

**Issue**: ClassyFire API timeout
- **Solution**: Internet connection required. API may be temporarily down; retry later.

**Issue**: PubChem API rate limiting
- **Solution**: The script includes 0.5s delays. For large datasets, consider increasing delay or splitting data.

**Issue**: Memory errors with large DrugBank file
- **Solution**: Filter by molecular weight first (line in cell 6): `drugbank[drugbank['molweight']<=1210]`

---

## Citation

If you use these scripts in your research, please cite:
- Prodrugs [Ting-Hao Kuo et al., bioRxiv (2025)](https://www.biorxiv.org/content/10.64898/2025.12.09.692405v1)
- ClassyFire: [Djoumbou Feunang et al., J Cheminform (2016)](https://doi.org/10.1186/s13321-016-0174-y)
- The RDKit: [RDKit: Open-source cheminformatics](http://www.rdkit.org)
- DrugBank: [Craig Knox et al., Nucleic Acids Res. (2024)](https://doi.org:10.1093/nar/gkad976)

---

## Contact

For questions or issues please contact: tinghao.kuo@embl.de and mahnoor.zulfiqar@embl.de, or submit an issue to the GitHub Repo.

