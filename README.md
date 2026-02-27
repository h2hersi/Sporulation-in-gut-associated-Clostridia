# Sporulation in Gut-Associated Clostridia

This repository contains all scripts used for the Major Research Project in Bioinformatics and Systems Biology.

## Project Overview

The aim of this study was to investigate the presence of sporulation-associated genes across selected gut-associated Bacillota species.

The workflow included:

1. Orthology inference using OrthoFinder
2. Homology searches using phmmer (HMMER)
3. Parsing of search results
4. Construction of a presence–absence matrix (PAM)
5. Downstream analysis and visualization in R

---

## Repository Structure

01_orthofinder/
- run_orthofinder.sh

02_phmmer/
- phmmer_search.sh
- parse_phmmer_output.sh

03_postprocessing/
- build_pam.R
- heatmap_generation.R
- export_to_excel.R

---

## Software Used

- OrthoFinder
- HMMER (phmmer)
- R
- ComplexHeatmap package

---

## Author

H. Hersi  
Master Bioinformatics and Systems Biology
