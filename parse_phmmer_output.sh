#!/bin/bash
# Parse phmmer output to extract UniProt IDs
# Input: *_hits.tbl files
# Output: *_present_genes.txt per species

for tbl in *_hits.tbl; do
    species=$(basename "$tbl" _hits.tbl)
    echo "Processing $species ..."
    grep -v '^#' "$tbl" | awk '{split($3,a,"|"); print a[2]}' | sort | uniq > "${species}_present_genes.txt"
    echo "  Found $(wc -l < ${species}_present_genes.txt) genes"
done

echo "Parsing completed."
