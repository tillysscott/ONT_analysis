#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 10
#SBATCH --mem 50G

########################################################
# de novo assemble ont with wtdbg2 (redbean)
# version 2.5
## Uses fuzzy Bruijn graph
## https://github.com/ruanjue/wtdbg2
#######################################################

# set up

## Add wtdbg2 to path
export PATH=$PATH:~/sharedscratch/apps/wtdbg2

## set file paths and variable names
export input="../186-T3S2.unclassified_kraken_out.fq"
export prefix="186-T3S2_kraken_redbean"
export outdir="S_1-e2-A"

## make output directory
mkdir $outdir

# Assemble raw reads, generating contig layout and edge sequences
wtdbg2 -x ont -t 10 -i $input -fo $outdir/$prefix -S 1 -A 
## optimised settings

## OPTIONS
### --edge-min 2 --rescue-low-cov-edges
### -g genome size
### -x sequencing technology
### options on github to change for low coverage to optimise
### "For data of relatively low coverage, you may increase this sampling rate by reducing -S. \
	#This will greatly increase the peak memory as a cost, though" Default 4, can set to 1, or 2 or 3. 2 or 1 suggested
### Option -e, which defaults to 3, specifies the minimum read coverage of an edge in the assembly graph.\
       #	You may adjust this option according to the overall sequencing depth, too. 
### Option -A also helps relatively low coverage data at the cost of performance.

# Generate final consensus (.fa)
wtpoa-cns -t 16 -i $outdir/$prefix.ctg.lay.gz -fo $outdir/$prefix.ctg.fa
