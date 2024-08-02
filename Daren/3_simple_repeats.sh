#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 20
#SBATCH --mem 48G
#SBATCH --partition=uoa-compute

mkdir -p logs 01_simple_out 02_arthropoda_out 03_known_out 04_unknown_out
echo Directories generated: logs 01_simple_out 02_arthropoda_out 03_known_out 04_unknown_out

module load repeatmasker

export genome="Platorchestia_hallaensis"

#Masking round 1

RepeatMasker -pa 20 -a -e ncbi -dir 01_simple_out -noint -xsmall ${genome}.fa 2>&1 | tee logs/01_simplemask.log
