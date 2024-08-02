#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH -c 40
#SBATCH --mem 80G
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH -p uoa-compute


####
#SET UP
export genus="Hirondellea_PacBio-pdrnd1"
module load repeatmodeler/2.0.2-sing
#expect perl errors

BuildDatabase -name $genus $genus.fa

RepeatModeler -database $genus -LTRStruct  -pa 40
#-recoverDir RM_3564787.MonMay151532272023 

