library(tidyverse)

# by fraction
#library(tidyverse)

df2 <- read.table("08_TE_CpG/Percent_10x_5mCpG_CpG.order.tab", 
                  sep = "\t", header=TRUE)
str(df2)

df2$order <- factor(df2$order, levels = c("LINE", "SINE", "Penelope", "LTR", "DIRS", "TIR", "Maverick", "Crypton", "Helitron", 
                                          "Unknown"))

cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D9CB11", "#0072B2", "#D55E00", "#A21147", "#999999")


div_cpg <- ggplot(df2, aes(x = percdiv, y= Percent_5mCpG_CpG, colour=order)) +
  geom_point(size = 1) +
  labs(x = "% divergence to consensus",
       y = "% methylated CpG sites", 
       colour = "TE order")   +
  scale_colour_manual(values = cbPalette2)


ggsave(div_cpg,
       filename = "08_TE_CpG/TEdiv_CpG_mCpG_10x.png",
       bg = "transparent",
       width = 15, height = 10, dpi = 300, units = "cm", device='png')


# facet wrap by order with free y
div_cpg_order <- ggplot(df2, aes(x = percdiv, y= Percent_5mCpG_CpG, colour = order)) +
  geom_point(size = 1) +
  labs(x = "% divergence to consensus",
       y = "% methylated CpG sites",
       colour = "TE order")   +
  scale_colour_manual(values = cbPalette2)  +
  facet_wrap(~ order, scales = "free_y")


ggsave(div_cpg_order,
       filename = "08_TE_CpG/TEdiv_CpG_mCpG_10x_order_freey.png",
       bg = "transparent",
       width = 15, height = 10, dpi = 300, units = "cm", device='png')

# repeat for 40x coverage filter
df2 <- read.table("08_TE_CpG/Percent_40x_5mCpG_CpG.order.tab", 
                  sep = "\t", header=TRUE)
str(df2)

df2$order <- factor(df2$order, levels = c("LINE", "SINE", "Penelope", "LTR", "DIRS", "TIR", "Maverick", "Crypton", "Helitron", 
                                          "Unknown"))

cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D9CB11", "#0072B2", "#D55E00", "#A21147", "#999999")


div_cpg <- ggplot(df2, aes(x = percdiv, y= Percent_5mCpG_CpG, colour=order)) +
  geom_point(size = 1) +
  labs(x = "% divergence to consensus",
       y = "% methylated CpG sites", 
       colour = "TE order")   +
  scale_colour_manual(values = cbPalette2)


ggsave(div_cpg,
       filename = "08_TE_CpG/TEdiv_CpG_mCpG_40x.png",
       bg = "transparent",
       width = 15, height = 10, dpi = 300, units = "cm", device='png')


# facet wrap by order with free y
div_cpg_order <- ggplot(df2, aes(x = percdiv, y= Percent_5mCpG_CpG, colour = order)) +
  geom_point(size = 1) +
  labs(x = "% divergence to consensus",
       y = "% methylated CpG sites",
       colour = "TE order")   +
  scale_colour_manual(values = cbPalette2)  +
  facet_wrap(~ order, scales = "free_y")


ggsave(div_cpg_order,
       filename = "08_TE_CpG/TEdiv_CpG_mCpG_40x_order_freey.png",
       bg = "transparent",
       width = 15, height = 10, dpi = 300, units = "cm", device='png')


