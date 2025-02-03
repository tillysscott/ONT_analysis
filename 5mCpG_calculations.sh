#!/bin/bash

# count number of C, G, A and T in the assembly
grep -v ">" flyegenome450_assembly.fa | awk -F\[Cc] '{print NF-1}' | awk '{SUM+=$1}END{print SUM}' > flye_C.txt
grep -v ">" flyegenome450_assembly.fa | awk -F\[Gg] '{print NF-1}' | awk '{SUM+=$1}END{print SUM}' > flye_G.txt
grep -v ">" flyegenome450_assembly.fa | awk -F\[Tt] '{print NF-1}' | awk '{SUM+=$1}END{print SUM}' > flye_T.txt
grep -v ">" flyegenome450_assembly.fa | awk -F\[Aa] '{print NF-1}' | awk '{SUM+=$1}END{print SUM}' > flye_A.txt

# count the number of CG dinucleotides in the assembly
module load seqtk
seqtk seq -l 0 flyegenome450_assembly.fa | grep -v ">" | grep -o "[Cc][Gg]" | wc -l

# if bedfile is diploid/two stranded, combine orientations, recalculate percentage modified, and filter for percentage modified >=50%
##bedtools merge -i 450.pass.methyl.bedMethyl -d 0 -c 10,11,12,13,14,15,16,17,18 -o sum |  awk '{print $0, ($6/$4)*100}' | awk '$13 >= 50' > 450.pass.methyl.bedMethyl.mergedSites_filtered50.bed

# count number of CpG sites that are methylated in >= 50% of reads
awk '$11 >= 50' 450.CG.bedMethyl | wc -l

# count number of CpG sites that are methylated in >= 50% of reads AND have coverage >= 10x
awk '$11 >= 50' 450.CG.bedMethyl | awk '$5 >= 10' | wc -l


# count number of CpG sites that are methylated in >= 50% of reads AND have coverage >= 20x
awk '$11 >= 50' 450.CG.bedMethyl | awk '$5 >= 20' | wc -l


# count number of CpG sites that are methylated in >= 50% of reads AND have coverage >= 40x
awk '$11 >= 50' 450.CG.bedMethyl | awk '$5 >= 40' | wc -l

