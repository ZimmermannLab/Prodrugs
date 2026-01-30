# Structure Prediction

This directory contains script for generating molecular docking structures [boltz.sh](https://github.com/ZimmermannLab/Prodrugs/blob/main/structure_prediction/boltz.sh). 

## Contents
- `boltz.sh` — Main script used to run the Boltzmann/structure-prediction step.
- `input/` — Sequence files required by the script.

## Requirements
- Bash (or a POSIX-compatible shell)
- ***Python***:  >= 3.9

## Usage
1. Place required input files in the `input/` directory.
2. Make the script executable:
   ```bash
   chmod +x boltz.sh
   ```
3. Run the script:
   ```bash
   ./boltz.sh
   ```

## Notes
- Check the top of `boltz.sh` for configurable options and dependency notes.
- Outputs are written alongside the script or in subfolders created by the script—inspect `boltz.sh` for exact paths.

## Citation

If you use these scripts in your research, please cite:  
- Prodrugs [Ting-Hao Kuo et al., bioRxiv (2025)](https://www.biorxiv.org/content/10.64898/2025.12.09.692405v1)  
- Wohlwend, J., Corso, G., Passaro, S., Getz, N., Reveiz, M., Leidal, K., Swiderski, W., Atkinson, L., Portnoi, T., Chinn, I., Silterra, J., Jaakkola, T., & Barzilay, R. (2024). Boltz-1 Democratizing Biomolecular Interaction Modeling. _Biorxiv_. https://doi.org/10.1101/2024.11.19.624167
- Mirdita, M., Schütze, K., Moriwaki, Y., Heo, L., Ovchinnikov, S., & Steinegger, M. (2022). ColabFold: making protein folding accessible to all. _Nature Methods_, _19_(6), 679–682. https://doi.org/10.1038/s41592-022-01488-1


## **Contact**
  
For questions or issues please contact: [tinghao.kuo@embl.de](mailto:tinghao.kuo@embl.de) and resul.elgin@embl.de, or submit an issue to the GitHub Repo.
