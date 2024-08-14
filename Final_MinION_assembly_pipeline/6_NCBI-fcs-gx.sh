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
export gx_outdir="fcs-gx_out"
export prefix="Hirondellea_PacBio-pdrnd1"
export taxid="6821" #amphipoda

## create output directory
mkdir $gx_outdir

## load programme
module load fcs

# 4 : Screen the genome for contamination using fcs-gx
fcs.py screen genome --fa $prefix.clean.fa --out-dir ./$gx_outdir/ --gx-db $GXDB_LOC --tax-id $taxid 

# 5 : Clean the genome of contaminants using fcs-gx - Mask contaminants
cat $prefix.clean.fa | fcs.py clean genome --action-report ./$gx_outdir/$genome.$taxid.fcs_gx_report.txt --output $prefix.gxmasked.clean.fa --contam-fa-out $prefix.gxmasked.contam.fa

# 6 : OR Clean the genome of contaminants using fcs-gx - split the assembly at contaminants 
#sed -i 's/FIX/SPLIT/g' ./$gx_outdir/$genome.$taxid.fcs_gx_report.txt

#cat $prefix.clean.fa | fcs.py clean genome --action-report ./$gx_outdir/$genome.$taxid.fcs_gx_report.txt --output $prefix.gxsplit.clean.fa --contam-fa-out $prefix.gxsplit.contam.fa
