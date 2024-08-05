#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 10
#SBATCH --mem 100G

###################################################
# kraken2 analysis
## designed to be run on reads
### Sue, see if this works using my database, if not we can get you your own
#
# edit paths in Step 1
# edit prefix in Step 2
# edit file name in "$(cat 390_input_fq.txt)" in Step 2
#
################################################

# Step 1 - generate list of fastq files to use

### list (ls) files in basecall_guppy/pass folder, put in new text (.txt) file (>)
#
ls Tilly390/20240123_1707_MN44600_FAY36878_57d81613/basecall_guppy/pass/*.fastq.gz > 390_input_fq.txt
#
### this text file contains the list of fastq.gz files to use in $(cat ) step

# Step 2 - run kraken2

module load kraken2

export DBNAME="/uoa/home/r01ms21/sharedscratch/Test_2/kraken2/kraken2/DB_standard_kraken2"
export prefix="390"
export outdir="390_analysis"

###

kraken2 --db $DBNAME --threads 10 $(cat 390_input_fq.txt)\
        --unclassified-out $outdir/$prefix.unclassified_kraken_out.fq --classified-out $outdir/$prefix.classified_kraken_out.fq \
        --output $outdir/$prefix.kraken_out.out --report $outdir/$prefix.kraken.report \
        --gzip-compressed


##################################################################################################
# Remove human contamination from 186-T3S2.classified_kraken_out.fq using KrakenTools
# https://github.com/jenniferlu717/KrakenTools/tree/master
#################################################################################################

# set up
#export PATH=$PATH:~/sharedscratch/apps/KrakenTools

# Run extract_kraken_reads.py 
#python /uoa/home/r01ms21/sharedscratch/apps/KrakenTools/extract_kraken_reads.py \
	#-k $outdir/$prefix.kraken_out.out \
	#-s $outdir/$prefix.classified_kraken_out.fq \
	#-o $outdir/$prefix.classified_nohuman_kraken_out.fa \
	#--taxid 9606 --exclude --fastq-output

#cat $outdir/$prefix.unclassified_kraken_out.fq $outdir/$prefix.classified_nohuman_kraken_out.fq > $outdir/$prefix.unclassified_classifiednohuman_kraken_out.fq


# Run extract_kraken_reads.py
#python /uoa/home/r01ms21/sharedscratch/apps/KrakenTools/extract_kraken_reads.py \
#        -k $outdir/$prefix.kraken_out.out \
#        -s $outdir/$prefix.classified_kraken_out.fq \
#        -o $outdir/$prefix.classified_human_kraken_out.fq \
#        --taxid 9606 


######
# Other options:

# --quick ##Quick operation: Rather than searching all l-mers in a sequence, stop classification after the first database hit
# --minimum-hit-groups ## Hit group threshold: The option --minimum-hit-groups will allow you to require multiple hit groups
###(a group of overlapping k-mers that share a common minimizer that is found in the hash table) be found before declaring a
### sequence classified, which can be especially useful with custom databases when testing to see if sequences either do or
### do not belong to a particular genome
