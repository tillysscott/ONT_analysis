#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH -c 8
#SBATCH --mem 100G
#SBATCH -p uoa-compute

#load programmes
module load openjdk/11.0.15_10
module load r
export PATH=$PATH:~/sharedscratch/apps/qualimap_v2.3

#set up variables
export inbam="all-Bathy_kraken_redbean_p19.racon4.purged.gxsplit_clean.bam"

qualimap bamqc -bam $inbam -c -nt 8 --java-mem-size=4G -outfile $inbam.pdf 
