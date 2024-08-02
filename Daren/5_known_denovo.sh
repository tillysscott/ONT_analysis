#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH --partition=uoa-compute

module load repeatmasker

export genome="Platorchestia_hallaensis"
export library="all-families.prefix.consensus1"
#rename outputs from previous round
# round 2: rename outputs
rename simple_mask.masked.fa arthropoda_mask 02_arthropoda_out/${genome}*
rename .masked .masked.fa 02_arthropoda_out/${genome}*
echo Outputs from arthropoda round renamed

#Masking round 3: known de novo repeats

RepeatMasker -pa 20 -a -e ncbi -dir 03_known_out -nolow \
       -lib ${library}.expanded.fa.known	\
       02_arthropoda_out/${genome}.arthropoda_mask.masked.fa 2>&1 | tee logs/03_knownmask.log
