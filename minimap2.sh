#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH -c 10
#SBATCH --mem 100G
#SBATCH -p uoa-compute



#######################################################
#Use minimap2 to align fastq files from ONT to PacBio reference
#######################################################
# set up files and paths
ref="../../RMod/WG_Hirondellea/Hirondellea_PacBio-pdrnd1.fa"
reads="Hgigas_ONT.unclassified_kraken_out.fq"
out="Hgigas_ONT.unclassified_kraken"
tempdir="temp_minimap2_2"

mkdir $tempdir

# load programmes
module load minimap2
module load samtools

# align ONT against reference genome. 10 threads. BAM output format.
minimap2 -ax map-ont -t 10 --split-prefix $tempdir $ref $reads | samtools sort -@10 -O bam -o $out.minimap.bam
## indexes must be split, requires --split-prefix and temporary directory. 
## Will split index for every ~NUM input target (.: reference) bases [default 4G], change with -I

# index BAM file and get alignment statistics
samtools index -@8 $out.minimap.bam
samtools flagstat -@8 $out.minimap.bam > $out.minimap.bam.stats



########################################################
# in case of future use:
## extract aligned reads as new fastq file
##samtools fastq -@10 -F2308 $out.minimap.bam > $out.mi
