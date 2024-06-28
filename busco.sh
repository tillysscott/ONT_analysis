#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 15
#SBATCH --mem 96G

################################################
# busco analysis
## to assess whole genome assembly quality
################################################

## set up file paths and file name variable
export genome="assembly.fasta"
export wd="../MinION/EMPSEB_186_analysis/flye_4_output"

# set up programme
module load busco

# run busco analysis
#busco -i ${genome}.fa -o ${genome}_busco -m genome -l /uoa/home/r01ms21/sharedscratch/Test_2/busco/busco_downloads/lineages/arthropoda_odb10 -c 15
busco -i ${wd}/${genome} -o ${wd}/${genome}_busco -m genome -l /uoa/home/r01ms21/sharedscratch/Test_2/busco/busco_downloads/lineages/arthropoda_odb10 -c 15
