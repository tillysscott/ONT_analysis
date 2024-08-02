#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH --partition=uoa-compute

module load repeatmasker
module load repeatmodeler

export genome="Platorchestia_hallaensis"


echo Process Repeats:
# resummarize repeat compositions from combined analysis of all RepeatMasker rounds
ProcessRepeats -a -species arthropoda 05_full_out/${genome}.full_mask.cat.gz 2>&1 | tee logs/05_fullmask.log

