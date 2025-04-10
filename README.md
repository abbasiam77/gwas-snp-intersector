# GWAS SNP Intersector & Cleaner

This bash script allows researchers to:
1. **Clean raw GWAS SNP BED files**
2. **Lift genomic coordinates (e.g., hg38 to hg19)**
3. **Intersect SNPs with genomic regions of interest (like enhancers)**

## 🧠 Use Case
You have a BED file of SNPs associated with a brain disorder (e.g., psychosis), and you want to see which ones fall within specific genomic features like **forebrain enhancers**.

## 🛠 Requirements

- Ubuntu/Linux terminal (works great in WSL for Windows)
- [`bedtools`](https://bedtools.readthedocs.io/)
- [`liftOver`](https://genome.ucsc.edu/cgi-bin/hgLiftOver) binary installed and executable
- UCSC chain file (e.g., `hg38ToHg19.over.chain.gz`)

## 📂 Input Files

- **GWAS SNPs BED** file with columns:
  ```
  <chr_number> <start> <end> <rsID>
  ```
- **Chain file** for liftOver (e.g., `hg38ToHg19`)
- **Genomic regions BED** (e.g., enhancers)

## 📤 Output Files

- `cleaned_sorted_SNPs.bed`: Cleaned, formatted SNPs
- `lifted_SNPs_hg19.bed`: Successfully mapped SNPs
- `unMapped_SNPs.bed`: SNPs that failed liftOver
- `SNPs_in_genomic_regions.bed`: Final intersected file with enhancer info

## ▶️ How to Use

1. **Customize paths** at the top of the script to match your local file locations.
2. Make the script executable:
   ```bash
   chmod +x intersect_cleaned_gwas_snps_with_regions.sh
   ```
3. Run it:
   ```bash
   ./intersect_cleaned_gwas_snps_with_regions.sh
   ```

## 📝 Notes

- Adjust paths in the script for your use case.
- The script assumes SNPs are in **hg38** and genomic features in **hg19**.
- You can adapt it for any other trait/disease or genome region of interest.

## 👤 Author

Prof. Amir Ali Abbasi  
National Center for Bioinformatics, Quaid-i-Azam University Islamabad  
Email: abbasiam@qau.edu.pk

## 📄 License

MIT License
