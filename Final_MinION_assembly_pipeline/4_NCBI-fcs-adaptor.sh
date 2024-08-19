#!/bin/bash 

#SBATCH -c 1
#SBATCH --mem 500G 
#SBATCH -p spot-vhmem
#SBATCH -t 96:00:00


######################################################
# NCBI foreign contaminant screening tool suite
# FCS-adaptor and FCS-GX
## Information on github about use https://github.com/ncbi/fcs?tab=readme-ov-file
## Information on how to run on Maxwell on email from digitalresearch@abdn.ac.uk subject [#SR-1481804] Enquiry update: Programme installation on Maxwell
######################################################

# 1 : set up
## create variables and directories
export genome="../Hirondellea_PacBio-pdrnd1"
export adap_outdir="fcs-adaptor_out"
export prefix="Hirondellea_PacBio-pdrnd1"

## create output directory
mkdir $adap_outdir

## load programme
module load fcs


# 2 : Screen the genome for adaptors using fcs-adaptor
run_fcsadaptor.sh --fasta-input $genome.fa --output-dir ./$adap_outdir --euk --container-engine singularity --image $FCS_ADAPTOR_IMAGE

# 3 : Clean the genome of adaptors using fcs-adaptor
cat $genome.fa | fcs.py clean genome --action-report ./$adap_outdir/fcs_adaptor_report.txt --output $prefix.clean.fa --contam-fa-out $prefix.contam.fa

