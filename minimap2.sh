#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH -c 10
#SBATCH --mem 100G
#SBATCH -p uoa-compute



#######################################################
#Use minimap2 to align fastq files from ONT to PacBio reference
#######################################################

ref="/uoa/home/r01ms21/sharedscratch/Test_2/RMod/WG_Hirondellea/Hirondellea_PacBio-pdrnd1.fa"
reads="390and394.unclassified_kraken_out.fq"
out="390and394.unclassified_kraken_out"


module load minimap2
minimap2 -ax map-ont -t 10 $ref $reads > $out.minimap.sam
