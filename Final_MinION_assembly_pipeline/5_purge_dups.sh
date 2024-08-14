#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 12
#SBATCH --mem 100G

##########################################################
#Use purge_dups to remove overlaps and create a haploid assembly
#Github: https://github.com/dfguan/purge_dups
#verion 1.2.6
#run successfully, apart from busco, on 06/08/24. Potentially fixed problem
##########################################################

# Set up
## Set up programmes
export PATH=$PATH:/uoa/home/r01ms21/sharedscratch/apps
module load zlib
module load minimap2
module load busco
export PATH=$PATH:/uoa/home/r01ms21/sharedscratch/apps/runner

## Set up variables and paths
export ref="../redbean/S1_A_e2_r_R_L1024_K2000_ad-1_l500_k0_p19/186-T3S2_kraken_redbean_p19.fa"
export listreads="fq_list.txt"
export localdirectory="localdir"
export prefix="p19"

#mkdir $localdirectory

# Step 1
##Generate a configuration file
#python /uoa/home/r01ms21/sharedscratch/apps/purge_dups-1.2.6/scripts/pd_config.py \
#	-l $localdirectory -n config.$prefix.json $ref $listreads

# Step 2
## Edit the configuration file if needed
### Should busco database be file path to the datbase?
#/uoa/home/r01ms21/sharedscratch/Test_2/busco/busco_downloads/lineages/arthropoda_odb10

# Step 3
## Run the purge dups pipeline
python /uoa/home/r01ms21/sharedscratch/apps/purge_dups-1.2.6/scripts/run_purge_dups.py -p bash config.$prefix.json \
	/uoa/home/r01ms21/sharedscratch/apps/purge_dups-1.2.6/src \
	Bathy-186-p19

