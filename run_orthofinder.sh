#!/bin/bash
# Activate the conda environment for OrthoFinder
# Then run OrthoFinder using DIAMOND and STAG
# Input: folder containing proteome FASTA files (*.faa)
# Output: OrthoFinder results in default folder

conda activate orthofinder

orthofinder -f . -t 8 -a 8 -S diamond

echo "OrthoFinder run completed."
