#!/bin/bash

for tbl in *_hits.tbl
do
    species=$(basename "$tbl" _hits.tbl)

    echo "Processing $species"

    grep -v '^#' "$tbl" | \
    awk '{split($3,a,"|"); print a[2]}' | \
    sort | uniq > "${species}_present_uniprot.txt"

    echo "  Found $(wc -l < ${species}_present_uniprot.txt) genes"
done
