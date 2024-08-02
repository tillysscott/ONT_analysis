#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH --partition=uoa-compute

module load repeatmasker

export genome="Platorchestia_hallaensis"

# rename outputs from previous round to something more informative
rename fa simple_mask 01_simple_out/${genome}* #replace the string 'fa' with 'simple_mask'
rename .masked .masked.fa 01_simple_out/${genome}*
echo Outputs from simple repeats round renamed

#Masking round 2 - homology based

RepeatMasker -pa 20 -a -e ncbi -s -dir 02_arthropoda_out -nolow -species arthropoda \
	01_simple_out/${genome}.simple_mask.masked.fa 2>&1 | tee logs/02_arthropodamask.log
