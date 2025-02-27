library(tidyverse)

# rnd_5_family_2633_mc_Percent.tab
df2633 <- read.table("rnd_5_family_2633_mc_Percent.tab",
                  sep = "\t", header=TRUE)


#plot2633 <- ggplot(df2633, aes(x = percdiv, y= Percent_5mCpG_CpG)) +
#  geom_point(colour = "#E69F00") +
#  labs(x = "% divergence to consensus",
#       y = "% methylated CpG sites")

#ggsave(plot2633,
#       filename = "rnd-5_family-2633.Cpg_percent.png",
#       bg = "transparent",
#       width = 7, height = 7, dpi = 300, units = "cm", device='png')

# calculate mean age of methylated TE
r2633m <- na.omit(df2633[df2633$Percent_5mCpG_CpG > 0 ,])
#str(r2633m)
cat("mean percent divergence for rnd-5_family-2633")
summarise(r2633m, mean=mean(percdiv), sd=sd(percdiv)) #
df2633 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail

# rnd-1_family-87_cur_percent.tab
df87 <- read.table("rnd-1_family-87_cur_percent.tab",
                  sep = "\t", header=TRUE)


#plot87 <- ggplot(df87, aes(x = percdiv, y= Percent_5mCpG_CpG)) +
#  geom_point(colour = "#E69F00") +
#  labs(x = "% divergence to consensus",
#       y = "% methylated CpG sites")

#ggsave(plot87,
#       filename = "rnd-1_family-87.Cpg_percent.png",
#       bg = "transparent",
#       width = 7, height = 7, dpi = 300, units = "cm", device='png')

# calculate mean age of methylated TE
r87m <- na.omit(df87[df87$Percent_5mCpG_CpG > 0 ,])
#str(r87m)
cat("mean percent divergence for rnd-1_family-87")
summarise(r87m, mean=mean(percdiv), sd=sd(percdiv)) # 
df87 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail


# Dong-R4-1_Ldor_Percent.tab
df41 <- read.table("Dong-R4-1_Ldor_Percent.tab",
                  sep = "\t", header=TRUE)


#plot41 <- ggplot(df41, aes(x = percdiv, y= Percent_5mCpG_CpG)) +
#  geom_point(colour = "#E69F00") +
#  labs(x = "% divergence to consensus",
#       y = "% methylated CpG sites")

#ggsave(plot41,
#       filename = "Dong-R4-1_Ldor.Cpg_percent.png",
#       bg = "transparent",
#       width = 7, height = 7, dpi = 300, units = "cm", device='png')

# calculate mean age of methylated TE
r41m <- na.omit(df41[df41$Percent_5mCpG_CpG > 0 ,])
#str(r41m)
cat("mean percent divergence for Dong-R4-1_Ldor")
summarise(r41m, mean=mean(percdiv), sd=sd(percdiv)) #
df41 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail


#  rnd_6_family_914_Percent.tab
df914 <- read.table("rnd_6_family_914_Percent.tab",
                  sep = "\t", header=TRUE)


#plot914 <- ggplot(df914, aes(x = percdiv, y= Percent_5mCpG_CpG)) +
#  geom_point(colour = "#E69F00") +
#  labs(x = "% divergence to consensus",
#       y = "% methylated CpG sites")

#ggsave(plot914,
#       filename = "rnd-6_family-914.Cpg_percent.png",
#       bg = "transparent",
#       width = 7, height = 7, dpi = 300, units = "cm", device='png')

# calculate mean age of methylated TE
r914m <- na.omit(df914[df914$Percent_5mCpG_CpG > 0 ,])
#str(r914m)
cat("mean percent divergence for rnd-6_familt_914")
summarise(r914m, mean=mean(percdiv), sd=sd(percdiv)) # 
df914 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail


# rnd-1_family-316
df316 <- read.table("rnd-1_family-316_Percent.tab",
                  sep = "\t", header=TRUE)

r316m <- na.omit(df316[df316$Percent_5mCpG_CpG > 0 ,])
#str(r316m)
cat("mean percent divergence for rnd-1_family-316")
summarise(r316m, mean=mean(percdiv), sd=sd(percdiv)) # 23.46441
df316 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail


# rnd_6_family_2379_01
df6 <- read.table("rnd_6_family_2379_01_Percent.tab",
                  sep = "\t", header=TRUE)

r6m <- na.omit(df6[df6$Percent_5mCpG_CpG > 0 ,])
#str(r6m)
cat("mean percent divergence for rnd_6_family_2379_01")
summarise(r6m, mean=mean(percdiv), sd=sd(percdiv)) 
df6 %>% group_by(Percent_5mCpG_CpG) %>% summarise(mean=mean(percdiv), sd=sd(percdiv)) %>% tail
