#!/bin/bash

#SBATCH --time=120:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH -p uoa-compute


####
#SET UP
export genus="Hirondellea_PacBio-pdrnd1"
module load repeatmodeler/2.0.2
#expect perl errors in slurm.$JOBID.err

####
# Build genome database
BuildDatabase -name $genus $genus.fa

#Run RepeatModeler2
RepeatModeler -database $genus -LTRStruct  -pa 20

## If the run fails due to out of time etc then you can restart by adding
#-recoverDir RM_*
## Where RM_* is the RM_$runname folder, normally contains a day and date

