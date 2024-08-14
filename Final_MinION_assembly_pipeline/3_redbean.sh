#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH -p uoa-compute

########################################################
# de novo assemble ont with wtdbg2 (redbean)
# version 2.5
## Uses fuzzy Bruijn graph
## https://github.com/ruanjue/wtdbg2
### BEST SETTINGS TO TRY ARE: -k 0 -p 17 ;OR; -k 0 -p 19 ;OR; -k 15 -p0
#######################################################

# set up

## Add wtdbg2 to path
export PATH=$PATH:~/sharedscratch/apps/wtdbg2
module load minimap2
module load samtools

## set file paths and variable names
export input="../186-T3S2.unclassified_kraken_out.fq"
export prefix="186-T3S2_kraken_redbean_p19"
export outdir="S1_A_e2_r_R_L1024_K2000_ad-1_l500_k0_p19"

## make output directory
#rm -r -d $outdir
mkdir $outdir


# Assemble raw reads, generating contig layout and edge sequences
wtdbg2 -x ont -t 20 -i $input -fo $outdir/$prefix -S 1 -A --edge-min 2 --rescue-low-cov-edges -R \
	-L 1024 -K 2000 --aln-dovetail -1 -l 500 \
	-k 0 -p 19


# Generate consensus (.fa)
wtpoa-cns -t 20 -i $outdir/$prefix.ctg.lay.gz -fo $outdir/$prefix.ctg.fa


# polish consensus, not necessary if you want to polish the assemblies using other tools
minimap2 -t16 -ax map-ont -r2k $outdir/$prefix.fa $input | samtools sort -@8 > $outdir/$prefix.bam
samtools view -F0x900 $outdir/$prefix.bam | wtpoa-cns -t 16 -d $outdir/$prefix.fa -i - -fo $outdir/$prefix.polished.fa
