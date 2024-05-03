#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 10
#SBATCH --mem 100G

###################################################
# kraken2 analysis on assembled fasta
## detects contamination in reads, including bacterial, human and viral
### Sue see if this works using my database, if not we can get you your own
################################################

module load kraken2

export DBNAME="/uoa/home/r01ms21/sharedscratch/Test_2/kraken2/kraken2/DB_standard_kraken2"
export seq="390and394"

kraken2 --db $DBNAME --threads 10 $seq.fa \
        --unclassified-out $seq.unclassified_kraken_out.fq --classified-out $seq.classified_kraken_out.fq \
        --output $seq.kraken_out.out --report $seq.kraken.report 


######
# Other options:

# --quick ##Quick operation: Rather than searching all l-mers in a sequence, stop classification after the first database hit
# --minimum-hit-groups ## Hit group threshold: The option --minimum-hit-groups will allow you to require multiple hit groups
###(a group of overlapping k-mers that share a common minimizer that is found in the hash table) be found before declaring a
### sequence classified, which can be especially useful with custom databases when testing to see if sequences either do or
### do not belong to a particular genome
