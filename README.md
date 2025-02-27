# MinION_processing
MinION sequencing processing  
Scripts needed for Sue's methylation analysis  

## Assembly Pipeline
Run the programmes in Final_MinION_assembly_pipeline  
1. Basecall with Guppy, do QC (only keep Q-score>9 - 'pass'), trim adaptors, make statistics plots with Nanoplot
2. Remove contamination with kraken2 with standard database
3. cat any individuals of that species together
4. use wtdbg2 (redbean) to assemble: maps, builds consensus and polish. Best setting will be -S 1 -A --edge-min 2 --rescue-low-cov-edges -R -L 1024 -K 2000 --aln-dovetail -1 -l 500  AND EITHER -k 0 -p 19; -k 0 -p 17; -k 15 -p 0
5. polish with rounds of racon
6. Make sure assembly is haploid with Purge_dups
7. Remove any persisting adaptors with NCBI-fcs-adaptor
8. Check for any persisting contamination with NCBI-fcs-gx
9. Calculate assembly and coverage statistics and BUSCO score with BBMap/seqkit, minimap2, samtools and qualimap, and BUSCO arthropoda_10.  
At the end of this you should have 6 assemblies to choose from: k15, p17 and p17, all with and without polishing.
This data is low coverage genome skim so aim to maximise BUSCO score, assembly size, N50, percentage of reads mapped, and mininise number of contigs, mean coverage and standard deviation.


## Predict and mask TE
See TE_annotation/README.md

## Sue has predicted methylated Cpg sites:  
To calculate the percentage of CpG sites that are methylated in the assembly, see 5mCpG_calculations.sh  
To analyse methylated CpG in TE use scripts in ONT_CpG
