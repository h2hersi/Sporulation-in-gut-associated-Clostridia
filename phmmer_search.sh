#!/bin/bash
# Perform phmmer searches of all proteomes against reference Bacillota genes
# Input: *.faa proteome files
# Output: tabular hit files (*.tbl)

REF="bacillota.fasta"

for genome in *.faa; do
    base=$(basename "$genome" .faa)
    tbl_file="${base}_hits.tbl"
    echo "Running phmmer on $genome ..."
    phmmer --tblout "$tbl_file" "$REF" "$genome"
done

echo "All phmmer searches finished."
