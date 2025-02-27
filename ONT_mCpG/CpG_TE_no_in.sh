# find the number of methylated CpG sites that fall within a TE

# 1 set up
## define paths
rawbase=/uoa/home/r01ms21/sharedscratch/Test_2/GenomeSkimming/CpG
base=$rawbase/08_TE_CpG
genomename="450"

TE=$base/Hirondellea.full_mask.complex.percdiv.bed
methyl_CpGbed=$rawbase/450.CG_filter50_10x.bedMethyl


## load programmes
module load samtools/1.17
module load bedtools2
PATH=$PATH:/uoa/home/r01ms21/sharedscratch/apps/bedops

# 2 collapse TE positions so overlapping sites are only mentioned once in bed file
## see https://bedtools.readthedocs.io/en/latest/content/tools/merge.html
bedtools merge -i $TE > $base/overlapping_TE_merged.full_mask.complex.percdiv.bed
wc -l $base/overlapping_TE_merged.full_mask.complex.percdiv.bed # 137523

# 3 get number of methylated CpG within merged TE
sortBed -i $methyl_CpGbed | \
	bedmap --echo --bases-uniq $base/overlapping_TE_merged.full_mask.complex.percdiv.bed - | \
	tr "|" "\t" | \
	awk '{SUM+=$4}END{print SUM}'
#	> $base/Hirondellea.non-overlapping_methyl_CpG_num_in_TE.bed
# wc -l $base/Hirondellea.non-overlapping_methyl_CpG_num_in_TE.bed # 137523

# 4 count the number of mehtylated CpG in TE
awk '$4 >= 1' $base/Hirondellea.non-overlapping_methyl_CpG_num_in_TE.bed | awk '{SUM+=$4}END{print SUM}' # 
awk '{SUM+=$4}END{print SUM}' $base/Hirondellea.non-overlapping_methyl_CpG_num_in_TE.bed # 8895

# with filtering for 10x coverage - 3903
# with filtering for 40x coverage - 961

# 5 record number and tidy up
rm $base/overlapping_TE_merged.full_mask.complex.percdiv.bed $base/Hirondellea.non-overlapping_methyl_CpG_num_in_TE.bed

