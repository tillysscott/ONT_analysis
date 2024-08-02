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
rename  arthropoda_mask.masked.fa known_mask 03_known_out/${genome}*
rename .masked .masked.fa 03_known_out/${genome}*
echo Outputs from known masking round renamed

#Masking round 4: unknown de novo repeats

RepeatMasker -pa 20 -a -e ncbi -dir 04_unknown_out -nolow \
       -lib ${library}.reduced.fa.unknown	\
       03_known_out/${genome}.known_mask.masked.fa 2>&1 | tee logs/04_unknownmask.log
