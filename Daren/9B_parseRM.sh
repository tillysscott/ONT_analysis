#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 10
#SBATCH --mem 50G


#IN COMMAND LINE
#export genome="Platorchestia_hallaensis"
#mkdir -p 07_ParseRM_landscape
#mv ${genome}.fa 07_ParseRM_landscape/${genome}.full_mask.fa
#mv 05_full_out/${genome}.full_mask.align 07_ParseRM_landscape/${genome}.full_mask.align
#mv 9B_parseRM.sh 07_ParseRM_landscape/
#cd 07_ParseRM_landscape/

export PATH=$PATH:~/sharedscratch/apps/Parsing-RepeatMasker-Outputs
export PERL5LIB=$PERL5LIB:/opt/software/uoa.2022-06-29/2019/conda/miniconda3-4.6/pkgs/perl-bioperl-core-1.007002-pl526_2/lib/site_perl/5.26.2
export genome="Platorchestia_hallaensis"


#allLen=`seqtk comp ${genome}.fa | datamash sum 2`;
#parseRM.pl -v -i 05_full_out/${genome}.full_mask.align -p -g ${allLen} -l 50,1 2>&1 | tee logs/06_parserm.log


parseRM.pl -v -i ${genome}.full_mask.align -p -f -l 50,1 2>&1 | tee logs/06_parserm.log

#mv ${genome}.full_mask.fa ../${genome}.fa
#mv ${genome}.full_mask.align ../05_full_out/${genome}.full_mask.align
