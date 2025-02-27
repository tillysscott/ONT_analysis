library(tidyverse)

df2 <- read.table("Percent_5mCpG_CpG.tab", 
                  sep = "\t", header=TRUE)
str(df2)

#cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D9CB11", "#0072B2", "#D55E00", "#A21147", "#999999")




# facet wrap by order with free y
div_cpg_order <- ggplot(df2, aes(x = percdiv, y= Percent_5mCpG_CpG)) +
  geom_point(size = 1) +
  labs(x = "% divergence to consensus",
       y = "% methylated CpG sites")   +
#  scale_colour_manual(values = cbPalette2)  +
  facet_wrap(~ classification, scales = "free_y")


ggsave(div_cpg_order,
       filename = "TEdiv_CpG_mCpG_superfamily.png",
       bg = "transparent",
       width = 30, height = 30, dpi = 300, units = "cm", device='png')