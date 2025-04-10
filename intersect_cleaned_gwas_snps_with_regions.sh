#!/bin/bash

# This script cleans a raw BED file of GWAS SNPs and intersects it with a genomic feature file (e.g., enhancers).
# Designed for use in Ubuntu (e.g., WSL on Windows).
# Author: Prof. Amir Ali Abbasi, National Center for Bioinformatics, Quaid-i-Azam University Islamabad
# Email: abbasiam@qau.edu.pk
# License: MIT

# -------- USER-DEFINED PATHS -------- #
RAW_SNP_FILE_PATH="/mnt/d/path/to/your/raw_GWAS_file.bed"
OUTPUT_FOLDER="/mnt/d/path/to/your/output/folder"
CHAIN_FILE_PATH="$OUTPUT_FOLDER/hg38ToHg19.over.chain.gz"
GENOMIC_REGIONS_FILE="$OUTPUT_FOLDER/your_genomic_regions_file.bed"
FINAL_OUTPUT_FILE="$OUTPUT_FOLDER/SNPs_in_genomic_regions.bed"

# -------- STEP 1: Clean and sort the raw BED file -------- #
awk 'BEGIN{OFS="\t"} {gsub(/ /,""); $1="chr"$1; print}' "$RAW_SNP_FILE_PATH" \
  | sort -u -k1,1 -k2,2n > "$OUTPUT_FOLDER/cleaned_sorted_SNPs.bed"

# -------- STEP 2: LiftOver from hg38 to hg19 -------- #
liftOver "$OUTPUT_FOLDER/cleaned_sorted_SNPs.bed" "$CHAIN_FILE_PATH" \
         "$OUTPUT_FOLDER/lifted_SNPs_hg19.bed" "$OUTPUT_FOLDER/unMapped_SNPs.bed"

# -------- STEP 3: Intersect with genomic regions of interest -------- #
bedtools intersect -a "$OUTPUT_FOLDER/lifted_SNPs_hg19.bed" \
                   -b "$GENOMIC_REGIONS_FILE" \
                   -wa -wb > "$FINAL_OUTPUT_FILE"

echo "Done. Intersected SNPs with enhancer info saved to: $FINAL_OUTPUT_FILE"
