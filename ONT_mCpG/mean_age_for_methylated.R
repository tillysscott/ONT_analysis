> library(tidyverse)
> r6 <- read.table("rnd_6_family_2379_01.Cpg_fraction.bed", sep = "\t", header = T)
> str(r6)
'data.frame':   248876 obs. of  9 variables:
> r6m <- r6[r6$CpG_fraction > 0,]
> str(r6m)
'data.frame':   2399 obs. of  9 variables:
> summarise(r6m, mean=mean(percdiv))
      mean
1 8.735098
>
> r1 <- read.table("rnd-1_family-316.Cpg_fraction.bed", sep = "\t", header=T)
> str(r1)
'data.frame':   6841 obs. of  9 variables:
> str(r1m)
'data.frame':   1066 obs. of  9 variables:
> summarise(r1m, mean = mean(percdiv))
      mean
1 23.44606

