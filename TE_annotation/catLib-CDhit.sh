#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 8
#SBATCH --mem 48G

####
# set up environment
## Source miniconda3 installation and activate environment
source /opt/software/uoa/apps/miniconda3/latest/etc/profile.d/conda.sh
conda activate seqkit

####
# Add species tag to fasta headers
## Set Up variables and edit script
export species1="Abyssorchomene_rb"
#MANUALLY ADD SPECIES IDENTIFIED: firt 3 letters of genus, first 3 letters of Species and reference genome number

cat ${species1}-families.fa | seqkit fx2tab | awk '{ print "abySpp1_"$0 }' | seqkit tab2fx > ${species}-families.prefix.fa
echo Species identifier added to families.fa: ${species1}-families.prefix.fa 

## Set Up variables and edit script
export species2="Bathycallisoma_rb"
#MANUALLY ADD SPECIES IDENTIFIED: firt 3 letters of genus, first 3 letters of Species and reference genome number

cat ${species2}-families.fa | seqkit fx2tab | awk '{ print "batSch1_"$0 }' | seqkit tab2fx > ${species}-families.prefix.fa
echo Species identifier added to families.fa: ${species2}-families.prefix.fa 

####
# Join two or more TE libraries
cat ${species1}-families.prefix.fa ${species2}-families.prefix.fa > ${species1}_${species2}-families.prefix.fa
echo Consensus families files concatenated

## Check worked correctly
echo Count sequences in species-families-fa and check same as cat-families.fa
grep -c ">" ${species1}-families.prefix.fa
grep -c ">" ${species2}-families.prefix.fa
grep -c ">" ${species1}_${species2}-families.prefix.fa

####
# Collapse TE families that are the same TE family
## these settings are from manual curation handbook protocol 2

## Set Up
module load cdhit

## Run
cd-hit-est -i grep -c ">" ${species1}_${species2}-families.prefix.fa -o grep -c ">" ${species1}_${species2}-families.prefix.consensus.fa -T 8 -d 0 -aS 0.8 -c 0.8 -G 0 -g 1 -b 500

