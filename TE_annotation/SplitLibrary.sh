

## set up
export library="species1_species2.prefix.consensus"

## Split the library
cat ${species}-families.prefix.fa | seqkit fx2tab | grep -v "Unknown" | seqkit tab2fx > ${species}-families.prefix.fa.known
echo Known library generated: ${species}-families.prefix.fa.known

cat ${species}-families.prefix.fa | seqkit fx2tab | grep "Unknown" | seqkit tab2fx > ${species}-families.prefix.fa.unknown
echo Unknown library generated: ${species}-families.prefix.fa.unknown


# quantify number of classified elements
echo Number of classified elements
grep -c ">" ${species}-families.prefix.fa.known
# quantify number of unknown elements
echo Number of unknown elements
grep -c ">" ${species}-families.prefix.fa.unknown
