#!/bin/bash

#SBATCH --mem 100G

#adapted from
## https://github.com/schraderL/CobscuriorGenome/blob/master/analyses/TEvisualization/genomePlots.md ###


# 1 set up
## define paths
rawbase=/uoa/home/r01ms21/sharedscratch/Test_2/GenomeSkimming/CpG
base=$rawbase/08_TE_CpG
genomename="450"
TEout=$rawbase/05_full_out/flyegenome450_assembly.full_mask.out
	# this includes simple repeats
CpGbed=$base/flye450.CpG.bed

## load programmes
module load samtools/1.17
module load bedtools2
PATH=$PATH:/uoa/home/r01ms21/sharedscratch/apps/bedops

## create directory
mkdir $base

# 2 define windows
## these will be the TE positions, make sure to retain percentage divergence, TE name and classification, and not to use simple repeats
tail -n +4 $TEout | grep -v -e "Satellite" -e "Low_complexity" -e "Simple_repeat" -e "rRNA" -e "ARTEFACT" | \
	awk '{OFS = "\t"} {print $5, $6, $7, ".", $2, $9, $10, $11}' | \
	sortBed > $base/Hirondellea.full_mask.complex.percdiv.bed
## check worked as expected
tail -n +4 $TEout | grep -v -e "Satellite" -e "Low_complexity" -e "Simple_repeat" -e "rRNA" -e "ARTEFACT" | wc -l
	# 191301
wc -l $base/Hirondellea.full_mask.complex.percdiv.bed
	# wc -l $base/Hirondellea.full_mask.complex.percdiv.bed # I'm happy

# 3 get bed positions of all CpG dinucleotides in the genome
~/sharedscratch/apps/fastaRegexFinder.py -f flyegenome450_assembly.fa -r CG --noreverse > $CpGbed
	# use fastaRegexFinder.py to make bed file
awk '{FS = "\t";OFS = "\t"} {print $1, $2, $3-1}' $CpGbed > $base/genome_CpG_posistions_modified.bed
	# keep only the 3 bed columns, and subtract 1 from column 3, so the cpg position only mentions the C site (same as methylation.bed)
wc -l $base/genome_CpG_posistions_modified.bed
	# 4733889

# 4 get bed positions of methylated CpG dinucleotides
methyl_CpGbed10=$rawbase/450.CG_filter50_10x.bedMethyl
	# export new methylated CpG bed file
wc -l $methyl_CpGbed10 # 514205
methyl_CpGbed40=$rawbase/450.CG_filter50_40x.bedMethyl
	# export new methylated CpG bed file
wc -l $methyl_CpGbed40

# 5 get number of CpG sites within a TE
sortBed -i $base/genome_CpG_posistions_modified.bed | bedmap --echo --bases-uniq $base/Hirondellea.full_mask.complex.percdiv.bed - |tr "|" "\t" > $base/Hirondellea.CpG_num_in_TE.bed
wc -l $base/Hirondellea.CpG_num_in_TE.bed
	# 191301 - correct number of TE

# 6 get number of methylated CpG within TE
sortBed -i $methyl_CpGbed10 | bedmap --echo --bases-uniq $base/Hirondellea.full_mask.complex.percdiv.bed - |tr "|" "\t" > $base/Hirondellea.methyl_CpG_10x_num_in_TE.bed
wc -l $base/Hirondellea.methyl_CpG_10x_num_in_TE.bed
	# 191301 - correct number of TE
sortBed -i $methyl_CpGbed40 | bedmap --echo --bases-uniq $base/Hirondellea.full_mask.complex.percdiv.bed - |tr "|" "\t" > $base/Hirondellea.methyl_CpG_40x_num_in_TE.bed
wc -l $base/Hirondellea.methyl_CpG_40x_num_in_TE.bed
	# 191301 - correct number of TE

# 7 sort naming in CpG number output file
cat $base/Hirondellea.CpG_num_in_TE.bed | sed 's/LINE\/Penelope/Penelope/g' | sed 's/LTR\/DIRS/DIRS/g' | sed 's/DNA\/Crypton/Crypton\/Crypton/g' | sed 's/DNA\/Maverick/Maverick/g' | sed 's/RC\/Helitron/Helitron/g' | sed 's/SINE\/tRNA/tRNA/g' | sed 's/tRNA/SINE\/tRNA/g' > $base/Hirondellea.CpG_num_in_TE.named.bed
	# correct order level
wc -l $base/Hirondellea.CpG_num_in_TE.named.bed # 191301

# 8 remove redundant columns in methylated CpG output
awk '{FS = "\t";OFS = "\t"} {print $1, $2, $3, $5, $6, $7, $9}' $base/Hirondellea.methyl_CpG_10x_num_in_TE.bed > $base/Hirondellea.methyl_CpG_10x_num_in_TE.reduced.bed
awk '{FS = "\t";OFS = "\t"} {print $1, $2, $3, $5, $6, $7, $9}' $base/Hirondellea.methyl_CpG_40x_num_in_TE.bed > $base/Hirondellea.methyl_CpG_40x_num_in_TE.reduced.bed

# 9 add headers
echo Contig qstart qend ignore percdiv orientation rname classification CpG_no | awk '{OFS = "\t"} {print $1, $2, $3, $4, $5, $6, $7, $8, $9}' > $base/cpg_header.txt
cat $base/cpg_header.txt $base/Hirondellea.CpG_num_in_TE.named.bed > $base/Hirondellea.CpG_num_in_TE.named_header.bed # wc -l 191302

echo Contig qstart qend percdiv orientation rname mCpG_no | awk '{OFS = "\t"} {print $1, $2, $3, $4, $5, $6, $7}' > $base/methyl_header.txt
cat $base/methyl_header.txt $base/Hirondellea.methyl_CpG_10x_num_in_TE.reduced.bed > $base/Hirondellea.methyl_CpG_10x_num_in_TE.reduced_header.bed # wc -l 191302
cat $base/methyl_header.txt $base/Hirondellea.methyl_CpG_40x_num_in_TE.reduced.bed > $base/Hirondellea.methyl_CpG_40x_num_in_TE.reduced_header.bed # wc -l 191302

# 10 calculate the percentage of methylated CpG/CpG in TE
## cd $base to run
module load r
Rscript $base/TE_CpG_maths.R
wc -l $base/Percent_10x_5mCpG_CpG.tab # 191302
wc -l $base/Percent_40x_5mCpG_CpG.tab # 191302

# 11 make column of orders
## NOTE r can't handle non-square columns, awk can
awk '{OFS = "\t"} {print $1, $2, $3, $4, $5, $6, $7, $8, $10, $11, $9}' $base/Percent_40x_5mCpG_CpG.tab \
	| awk '{OFS = "\t"} {gsub("/", "\t", $11); print}' | \
	awk '{OFS = "\t"} {print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11}' | \
	awk '{OFS = "\t"} {gsub("DNA", "TIR", $11); print}' | \
	sed 's/classification/order/' > $base/Percent_40x_5mCpG_CpG.order.tab
wc -l $base/Percent_10x_5mCpG_CpG.order.tab # 191302

# 12 get number of columns with and without CpG 
## run in $base
module load r
sbatch --mem 100G --wrap "Rscript 08_TE_CpG/calculate_number_of_types.R"

# 13 make graphs using R scripts
sbatch --mem 100G --wrap "Rscript 08_TE_CpG/CpG_plotting.R"




# 100 
	# for each TE order, add a column with that TE order
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "Helitron" | awk '{FS = "\t";OFS="\t"} {print $0, "Helitron"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "LINE" |  awk '{FS = "\t";OFS="\t"} {print $0, "LINE"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "Penelope" | awk '{FS = "\t";OFS="\t"} {print $0, "Penelope"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "SINE" | awk '{FS = "\t";OFS="\t"} {print $0, "SINE"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "LTR" | awk '{FS = "\t";OFS="\t"} {print $0, "LTR"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "DIRS" | awk '{FS = "\t";OFS="\t"} {print $0, "DIRS"}' \
	>> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "DNA" | awk '{FS = "\t";OFS="\t"} {print $0, "TIR"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
#cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "Crypton" | awk '{FS = "\t";OFS="\t"} {print $0, "Crypton"}' \
#        >> $base/Hirondellea.CpG_num_in_TE.named2.bed # there are no crypton
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "Maverick" | awk '{FS = "\t";OFS="\t"} {print $0, "Maverick"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "Unknown" | awk '{FS = "\t";OFS="\t"} {print $0, "Unknown"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed
cat $base/Hirondellea.CpG_num_in_TE.named.bed | grep "TIR" | awk '{FS = "\t";OFS="\t"} {print $0, "TIR"}' \
        >> $base/Hirondellea.CpG_num_in_TE.named2.bed

wc -l $base/Hirondellea.CpG_num_in_TE.named2.bed
