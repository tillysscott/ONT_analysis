# MinION_processing
MinION sequencing processing  
Scripts needed for Sue's methylation analysis  

## Assembly Pipeline
Run the programmes in Final_MinION_assembly_pipeline  
1. Basecall with Guppy, do QC (only keep Q-score>9), trim adaptors, make statistics plots with Nanoplot
2. Remove contamination with kraken2
3. use wtdbg2 (redbean) to assemble: maps, builds consensus and polish. Best setting will be -S 1 -A --edge-min 2 --rescue-low-cov-edges -R -L 1024 -K 2000 --aln-dovetail -1 -l 500  AND EITHER -k 0 -p 19; -k 0 -p 17; -k 15 -p 0
4. Remove any persisting adaptors with NCBI-fcs-adaptor
5. Make sure assembly is haploid with Purge_dups
6. Check for any persisting contamination with NCBI-fcs-gx  

## Predict and mask TE
See TE_annotation/README.md
