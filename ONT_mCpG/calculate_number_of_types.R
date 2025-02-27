#load package
library(tidyverse)

cpg <- read.table("08_TE_CpG/Percent_40x_5mCpG_CpG.order.tab",
                  sep = "\t", header=TRUE)
str(cpg)

# overall
cat("number of TE with no methylation (0)")
nrow(na.omit(cpg[cpg$Percent_5mCpG_CpG == 0 ,]))
cat("methylation greater than 0")
nrow(na.omit(cpg[cpg$Percent_5mCpG_CpG > 0 ,]))
cat("no cpg")
sum(is.na(cpg$Percent_5mCpG_CpG))

# LINE
cat("LINE percent is 0")
nrow(na.omit(cpg[cpg$order == "LINE" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("LINE greater than 0")
nrow(na.omit(cpg[cpg$order == "LINE" &
  cpg$Percent_5mCpG_CpG > 0 ,]))
cat("LINE with no CpG")
LINE <- cpg[cpg$order == "LINE", ]
sum(is.na(LINE$Percent_5mCpG_CpG))

# SINE
cat("SINE percent is 0")
nrow(na.omit(cpg[cpg$order == "SINE" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("SINE greater than 0")
nrow(na.omit(cpg[cpg$order == "SINE" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("SINE with no CpG")
SINE <- cpg[cpg$order == "SINE", ]
sum(is.na(SINE$Percent_5mCpG_CpG))

# Penelope
cat("Penelope percent is 0")
nrow(na.omit(cpg[cpg$order == "Penelope" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("Penelope greater than 0")
nrow(na.omit(cpg[cpg$order == "Penelope" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("Penelope with no CpG")
Penelope <- cpg[cpg$order == "Penelope", ]
sum(is.na(Penelope$Percent_5mCpG_CpG))

# LTR
cat("LTR percent is 0")
nrow(na.omit(cpg[cpg$order == "LTR" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("LTR greater than 0")
nrow(na.omit(cpg[cpg$order == "LTR" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("LTR with no CpG")
LTR <- cpg[cpg$order == "LTR", ]
sum(is.na(LTR$Percent_5mCpG_CpG))

# DIRS
cat("DIRS percent is 0")
nrow(na.omit(cpg[cpg$order == "DIRS" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("DIRS greater than 0")
nrow(na.omit(cpg[cpg$order == "DIRS" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("DIRS with no CpG")
DIRS <- cpg[cpg$order == "DIRS", ]
sum(is.na(DIRS$Percent_5mCpG_CpG))

# TIR
cat("TIR percent is 0")
nrow(na.omit(cpg[cpg$order == "TIR" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("TIR greater than 0")
nrow(na.omit(cpg[cpg$order == "TIR" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("TIR with no CpG")
TIR <- cpg[cpg$order == "TIR", ]
sum(is.na(TIR$Percent_5mCpG_CpG))

# Maverick
cat("Maverick percent is 0")
nrow(na.omit(cpg[cpg$order == "Maverick" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("Maverick greater than 0")
nrow(na.omit(cpg[cpg$order == "Maverick" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("Maverick with no CpG")
Maverick <- cpg[cpg$order == "Maverick", ]
sum(is.na(Maverick$Percent_5mCpG_CpG))

# Helitron
cat("Helitron percent is 0")
nrow(na.omit(cpg[cpg$order == "Helitron" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("Helitron greater than 0")
nrow(na.omit(cpg[cpg$order == "Helitron" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("Helitron with no CpG")
Helitron <- cpg[cpg$order == "Helitron", ]
sum(is.na(Helitron$Percent_5mCpG_CpG))

# Unknown
cat("Unknown percent is 0")
nrow(na.omit(cpg[cpg$order == "Unknown" &
                   cpg$Percent_5mCpG_CpG == 0 ,]))
cat("Unknown greater than 0")
nrow(na.omit(cpg[cpg$order == "Unknown" &
                   cpg$Percent_5mCpG_CpG > 0 ,]))
cat("Unknown with no CpG")
Unknown <- cpg[cpg$order == "Unknown", ]
sum(is.na(Unknown$Percent_5mCpG_CpG))
