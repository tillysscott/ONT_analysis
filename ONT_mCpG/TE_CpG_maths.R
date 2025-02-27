# combine the number of CpG dinucleotides in a TE and the number that are methylated

#load package
library(tidyverse)

#read in data
mcpg <- read.table("08_TE_CpG/Hirondellea.methyl_CpG_40x_num_in_TE.reduced_header.bed", 
                  sep = "\t", header=TRUE)
str(mcpg)

cpg <- read.table("08_TE_CpG/Hirondellea.CpG_num_in_TE.named_header.bed", 
                  sep = "\t", header=TRUE)
str(cpg)

#left join by Contig, qstart and qend and rname
joined <- left_join(mcpg, cpg, by = c("Contig", "qstart", "qend", "percdiv", "orientation", "rname"))
str(joined)

# do maths
maths <- joined %>%
  mutate(Percent_5mCpG_CpG = (mCpG_no/CpG_no)*100)
str(maths)

# export table
write.table(maths, "08_TE_CpG/Percent_40x_5mCpG_CpG.tab", sep = "\t", row.names = FALSE, quote = FALSE)
