#!/bin/bash

#SBATCH -c 16 
#SBATCH --mem 96G 
#SBATCH -p uoa-compute 
#SBATCH -t 96:00:00

###############################################
# flye to de novo assemble ONT reads
#
## installed locally with conda
###############################################

# PRIOR TO SUBMITTING JOB run next line in command line
#conda activate flye
#

flye --out-dir flye_output --genome-size 5g --threads 16 --nano-raw basecall_guppy/pass/*.fastq.gz

## NOTES:
#has a resume function
