#Daren-Graphs
#07/07/23 , updated 12/02/24, 27/05/24
# use new data from RMod2 libraries of H. gigas pacBio genome and long read ONT of B. schellenbergi
# masked with Daren pipeline, see page 67 of blue notebook for HPC locations

library(ggplot2)
library(dplyr)

# The palette with grey:
cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#999999", "#F0E442", "#D55E00")

###### Stacked bar - TE orders - loci counts dsa ----
# read in data
TEo <- read.csv("Data/EMPSEB_data/TE_RAD3sp.tbl.tidy.csv")
str(TEo)

TEo$Order <- factor(TEo$Order, levels = c("LINE", "SINE",
                                                            "LTR", "TIR", "Helitron", 
                                                            "Maverick", "Crypton", "Unknown",
                                          "Low_complexity", "Simple_repeat"))


#adjust coulour palette so same as repeat landscapes
cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", 
                "#F0E442", "#D55E00", "#999999", "#6ED7BA", "#6ED7BA")
#generate the plot
TEorder_stack <- ggplot(TEo, aes(x = PercentLociwTE, y = Species, 
                                       fill = Order)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "Cumulative % contigs with TE", fill = "TE Order")
TEorder_stack

### UNCLEAR - separate bar plots
#generate the plot
TEorder_sep <- ggplot(TEo, aes(x = PercentLociwTE, y = Species, 
                                 fill = Order)) +
  geom_bar(position = "dodge", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% contigs with TE", fill = "TE Order") + 
  facet_wrap(~ Order, scales = "free_x")
TEorder_sep

ggsave(TEorder_stack,
       filename = "Plots/Chapter1TE/TEorder_stackedbar_LOCIcounts.png",
       bg = "transparent",
       width = 25, height = 10, dpi = 300, units = "cm", device='png')


###### Stacked bar - TE orders - Hyallella ----
# read in data
TEo <- read.csv("Data/DarenSuperFamilies_DNAsorted.csv")
#correct name of TE order column
TEo <- dplyr::rename(TEo, TE_order = Superfamily)
str(TEo)
#remove unknown and non-TE information
TEo_filt2 <- TEo[TEo$TE_order != "non-TE" #&
                 # TEo$TE_order != "Unknown"
                 , ]
#remove erroneous Genera
TEo_filt2 <- TEo_filt2[TEo_filt2$Genus == "Hyalella"
                       , ]
str(TEo_filt2)

TEo_filt2$TE_order <- factor(TEo_filt2$TE_order, levels = c("LINE", "SINE",
                                                            "LTR", "TIR", "Helitron", 
                                                            "Maverick", "Crypton", "Unknown",
                                                            "Low_complexity", "Simple_repeat"))


#adjust coulour palette so same as repeat landscapes
#cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#F0E442", "#D55E00", "#999999")
#generate the plot
TEorder_stack <- ggplot(TEo_filt2, aes(x = PercentageOfSequence, y = ID, 
                                       fill = TE_order)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "TE Order")+
  xlim(0,80)
TEorder_stack

ggsave(TEorder_stack,
       filename = "Plots/Chapter1TE/TEorder_stackedbar_Hyalella.png",
       bg = "transparent",
       width = 25, height = 5, dpi = 300, units = "cm", device='png')


## plot as one colour for total repeat content #this double counts some TE!
## 01/06/24 use new data : Data/EMPSEB_data/TE_RAD3sp_TEandSR_tidy.csv
###### Horizontal bar - TE  - loci counts dsa ----
# read in data
TE2 <- read.csv("Data/EMPSEB_data/TE_RAD3sp_TEandSR_tidy.csv")
str(TE2)

##With old data that will over count, TE order data.
#TEmath <- TEo %>%
#  group_by(Species, Type) %>%
#  summarise(SumTE = sum(PercentLociwTE))

TE2$Type <- factor(TE2$Type, levels = c("Simple_repeat", "TE"))


#adjust coulour palette so same as repeat landscapes
cbPalette3 <- c( "#6ED7BA", "#0072B2")
#generate the plot
TE2_sep <- ggplot(TE2, aes(x = PercentLociwTE, y = Species, 
                                 fill = Type)) +
  geom_bar(position = "dodge", stat = "identity")   +
  scale_fill_manual(values = cbPalette3)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% contigs with TE", fill = "Repeat Type")  + 
  facet_wrap(~ Type, scales = "free_x")
TE2_sep

ggsave(TE2_sep,
       filename = "Plots/Chapter1TE/TE_TE_LOCIcounts.png",
       bg = "transparent",
       width = 35, height = 10, dpi = 300, units = "cm", device='png')

## plot simple and TE separately
## Simple only
TE2 <- TE2[TE2$Type == "Simple_repeats", ]
str(TE2)

TE2_sep <- ggplot(TE2, aes(x = PercentLociwTE, y = Species, 
                           fill = Type)) +
  geom_bar(position = "dodge", stat = "identity")   +
  scale_fill_manual(values = cbPalette3)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% contigs with TE", fill = "Repeat Type")  + 
  facet_wrap(~ Type, scales = "free_x")
TE2_sep

ggsave(TE2_sep,
       filename = "Plots/Chapter1TE/TE_sepbar_LOCIcounts.png",
       bg = "transparent",
       width = 28, height = 10, dpi = 300, units = "cm", device='png')


###### Stacked bar - TE orders - Hyallella ----
# read in data
TEo <- read.csv("Data/DarenSuperFamilies_DNAsorted.csv")
#correct name of TE order column
TEo <- dplyr::rename(TEo, TE_order = Superfamily)
str(TEo)
#remove unknown and non-TE information
TEo_filt2 <- TEo[TEo$TE_order != "non-TE" #&
                 # TEo$TE_order != "Unknown"
                 , ]
#remove erroneous Genera
TEo_filt2 <- TEo_filt2[TEo_filt2$Genus == "Hyalella"
                       , ]
str(TEo_filt2)

TEmath <- TEo_filt2 %>%
  group_by(ID, Type) %>%
  summarise(SumTE = sum(PercentageOfSequence))

TEmath$Type <- factor(TEmath$Type, levels = c("TE", "Simple_repeat"))


#adjust coulour palette so same as repeat landscapes
#cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#F0E442", "#D55E00", "#999999")
#generate the plot
TEorder_stack <- ggplot(TEmath, aes(x = SumTE, y = ID, 
                                       fill = Type)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette3)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "Repeat Type")+
  xlim(0,80)
TEorder_stack

ggsave(TEorder_stack,
       filename = "Plots/Chapter1TE/TE_stackedbar_Hyalella.png",
       bg = "transparent",
       width = 25, height = 5, dpi = 300, units = "cm", device='png')





# old code ----
#### Genome size vs TE% ----

tecontent <- read.csv("Data/DarenTEcontent.csv")
str(tecontent)

te_plot <- ggplot(tecontent, aes(x = GenomeSize, y = PercentTE)) +
  geom_point(aes(colour = Habitat),
             size = 8) + 
  labs(x = "Genome Size (Gb)",
       y = "% sequence from TE") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        #legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA),
        legend.position = c(0.35, 0.8)) + 
  xlim(0.75, 5.25) #+ geom_smooth(method = "lm", se = FALSE)
te_plot
ggsave(te_plot,
       filename = "Plots/TEvGb.png",
       bg = "transparent",
       width = 16.5, height = 20, dpi = 300, units = "cm", device='png')

##### ANOVA of shallows -----
teshallow <- tecontent[tecontent$Habitat != "Extreme-deep",]
telm <- lm(PercentTE ~ GenomeSize, data = teshallow)
anova(telm)

#assumptions - not perfect but they are ok
#linearity - yes
plot(telm, which = 1, add.smooth = FALSE)
#normality - residuals are normal
plot(telm, which = 2)
#constant variance - slight upwards trend
plot(telm, add.smooth = FALSE, which = 3)

###### log Percentage TE --------
lte <- mutate(teshallow, logPT = log10(PercentTE))
ltelm <- lm(logPT ~ GenomeSize, data = lte)
#constant variance - better
plot(ltelm, add.smooth = FALSE, which = 3)
#linearity - yes
plot(ltelm, which = 1, add.smooth = FALSE)
#normality - residuals are normal
plot(ltelm, which = 2)

anova(ltelm)
###### log genome size --------
l2te <- mutate(teshallow, logGS = log10(GenomeSize))
str(l2te)
l2telm <- lm(PercentTE ~ logGS, l2te)
ggplot(l2te) +
  geom_point(aes(x = logGS, y = PercentTE))

##### ANOVA of all -----
#exclude bathycallisoma as don't know genome size
teall <- tecontent[tecontent$Genus != "Bathycallisoma",]
l2te <- mutate(teall, logGS = log10(GenomeSize))
l2te <- mutate(l2te, logPTE = log10(PercentTE))
str(l2te)
telma <- lm(logPTE ~ logGS, data = l2te)
#constant variance - better
plot(telma, add.smooth = FALSE, which = 3)
#linearity - yes
plot(telma, which = 1, add.smooth = FALSE)
#normality - residuals are normal
plot(telma, which = 2)
anova(telma)

##### Compare TE content with barplot ----
tecontfilt <- tecontent[tecontent$Genus != "Orchestia_wrong" &
                          tecontent$Genus != "Paralicella_woPara" &
                          tecontent$Genus != "Paralicella_woPara_Para" &
                          tecontent$Genus != "NewHebridesHirondellea" &
                          tecontent$Genus != "KermadecHirondellea"  &
                          tecontent$Genus != "MarianaHirondellea"
                        ,]

tecontfilt$Genus <- factor(tecontfilt$Genus, levels = c("Gammarus", "Parhyale",
                              "Hyalella","Orchestia", 
                              "Trinorchestia", "Platorchestia",
                              "Paralicella", "Bathycallisoma",
                               "Hirondellea",
                              "390_flye_Hirondellea",
                              "394_flye_Hirondellea"
                              ))

flyeplot <- ggplot(tecontfilt, aes(x = Genus, y= PercentTE, fill = Habitat)) +
  geom_col()+
  scale_fill_manual(values = cbPalette) +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1))

ggsave(flyeplot,
       filename = "Plots/Chapter3/flye_Daren_TEcontent.png",
       bg = "transparent",
       width = 15, height = 15, dpi = 300, units = "cm", device='png')

#### Genome size vs CpGoe ----

tecontent <- read.csv("Data/DarenTEcontent.csv")
str(tecontent)

cpg_plot <- ggplot(tecontent) +
  geom_point(aes(x = GenomeSize, y = CpGoe, colour = Habitat),
             size = 4) + 
  labs(x = "Genome Size (Gb)",
       y = "CpG observed/expected ratio") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA))
cpg_plot

ggsave(cpg_plot,
       filename = "Plots/CpGvGb.png",
       bg = "transparent",
       width = 42, height = 29.7, dpi = 300, units = "cm", device='png')

### Superfamily ----

sf <- read.csv("Data/DarenSuperFamilies.csv")
str(sf)
  
sffiltered <- sf[sf$ID != "Shallow-water", ]

##### points 5 superfamilies -----
sfwounk <- sf[sf$Superfamily != "Unknown" &
              sf$Superfamily != "non-TE", ]
sfwounk$Superfamily <- factor(sfwounk$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                        "RC"))
sfpoint <- ggplot(sfwounk) +
  geom_point(aes(x = Superfamily, y = PercentageOfSequence,
                 colour = ID), size = 4) +
  labs(x = "TE Superfamily",
       y = "% sequence from TE") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA))
sfpoint

##### Separate bigs and littles -----
sfwounk1 <- sfwounk[sfwounk$Superfamily != "SINE" &
                      sfwounk$Superfamily != "RC", ]
sfpoint1 <- ggplot(sfwounk1) +
  geom_point(aes(x = Superfamily, y = PercentageOfSequence,
                 colour = ID), size = 4) +
  labs(x = "TE Superfamily",
       y = "% sequence from TE") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA))
sfpoint1
ggsave(sfpoint1,
       filename = "Plots/SFpoint1.png",
       bg = "transparent",
       #width = 42, height = 29.7, dpi = 300, units = "cm", 
       device='png')


sfwounk2 <- sfwounk[sfwounk$Superfamily == "SINE" |
                      sfwounk$Superfamily == "RC", ]

sfpoint2 <- ggplot(sfwounk2) +
  geom_point(aes(x = Superfamily, y = PercentageOfSequence,
                 colour = ID), size = 4) +
  labs(x = "TE Superfamily",
       y = "% sequence from TE") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA))
sfpoint2

ggsave(sfpoint2,
       filename = "Plots/SFpoint2.png",
       bg = "transparent",
       #width = 42, height = 29.7, dpi = 300, units = "cm", 
       device='png')

##### Pie charts -----


##### Bar plots per superfamily ------
sf <- read.csv("Data/DarenSuperFamilies.csv")
str(sf)
sfte <- sf[sf$Superfamily != "non-TE" &
             sf$Superfamily != "Unknown", ]

sfte$Superfamily <- factor(sfte$Superfamily, levels = c("LINE", "SINE",
                                            "LTR", "DNA", "RC")) #,
                                            #"Unknown"
sfte$Genus <- factor(sfte$Genus, levels = c("Hirondellea", "Bathycallisoma",
                                            "Paralicella", "Gammarus", "Parhyale",
                                            "Hyalella","Orchestia", 
                                            "Trinorchestia", "Platorchestia"))
str(sfte)



#Bar plot
sfteplot <- ggplot(sfte) +
  geom_col(aes(x = Genus, y = PercentageOfSequence,
               fill = Habitat), position = "dodge") +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA)) + 
  facet_wrap(~ Superfamily, scales = "free_y") + 
  labs(y = "% sequence from TE", x = "Genus")  +
  scale_fill_manual(values = cbPalette)
sfteplot

###### Lollipop plot ----
sfteplot2 <- ggplot(sfte, aes(x = Genus, y = PercentageOfSequence)) +
  geom_point(aes(colour = Habitat), size = 7) +
  geom_segment(aes(x = Genus, xend = Genus, 
                   y = 0, yend = PercentageOfSequence,
                   colour = Habitat),
               size = 2) +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        text = element_text(size=36),
        legend.text = element_text(size=30),
        #legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA),
        legend.position = c(0.85, -0.1)) + 
  facet_wrap(~ Superfamily, scales = "free_y") + 
  labs(y = "% sequence from TE", x = "Genus")  +
  scale_colour_manual(values = cbPalette)
sfteplot2

ggsave(sfteplot2,
       filename = "Plots/SFbar_Plot2.png",
       bg = "transparent",
       width = 37.8, height = 26.73, dpi = 300, units = "cm", device='png')

####### Lollipop plot - TE order - DNA separated ----
# read in data
TEo <- read.csv("Data/DarenSuperFamilies_DNAsorted.csv")
#correct name of TE order column
TEo <- dplyr::rename(TEo, TE_order = Superfamily)
str(TEo)
#remove unknown and non-TE information
TEo_filt <- TEo[TEo$TE_order != "non-TE" &
              TEo$TE_order != "Unknown", ]
#remove erroneous Genera
TEo_filt <- TEo_filt[TEo_filt$Genus != "Orchestia_wrong" &
                       TEo_filt$Genus != "Paralicella_woPara" &
                       TEo_filt$Genus != "Paralicella_woPara_Para", ]
str(TEo_filt)

TEo_filt$TE_order <- factor(TEo_filt$TE_order, levels = c("LINE", "SINE",
                                                        "LTR", "TIR", "Helitron", 
                                                        "Maverick", "Crypton")) #,
#"Unknown"
TEo_filt$Genus <- factor(TEo_filt$Genus, levels = c("Hirondellea", "Bathycallisoma",
                                            "Paralicella", "Gammarus", "Parhyale",
                                            "Hyalella", "Orchestia", 
                                            "Trinorchestia", "Platorchestia"))
str(TEo_filt)

#generate the plot
TEorder_plot_DNAsorted <- ggplot(TEo_filt, aes(x = Genus, y = PercentageOfSequence)) +
  geom_point(aes(colour = Habitat), size = 6) +
  geom_segment(aes(x = Genus, xend = Genus, 
                   y = 0, yend = PercentageOfSequence,
                   colour = Habitat),
               size = 2) +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA),
        #legend.position = c(0.85, -0.1)
        ) + 
  facet_wrap(~ TE_order, scales = "free_y") + 
  labs(y = "% sequence from TE", x = "Genus")  +
  scale_colour_manual(values = cbPalette)
TEorder_plot_DNAsorted

ggsave(TEorder_plot_DNAsorted,
       filename = "Plots/TEorder_plot_DNAsorted.png",
       bg = "transparent",
       width = 37.8, height = 26.73, dpi = 300, units = "cm", device='png')

###### Stacked bar - TE orders - DNA sorted ----
# read in data
TEo <- read.csv("Data/DarenSuperFamilies_DNAsorted.csv")
#correct name of TE order column
TEo <- dplyr::rename(TEo, TE_order = Superfamily)
str(TEo)
#remove unknown and non-TE information
TEo_filt2 <- TEo[TEo$TE_order != "non-TE" #&
                 # TEo$TE_order != "Unknown"
                 , ]
#remove erroneous Genera
TEo_filt2 <- TEo_filt2[TEo_filt2$Genus != "Orchestia_wrong" &
                       TEo_filt2$Genus != "Paralicella_woPara" &
                       TEo_filt2$Genus != "Paralicella_woPara_Para"&
                         TEo_filt2$Genus != "NewHebridesHirondellea" &
                         TEo_filt2$Genus != "KermadecHirondellea"  &
                         TEo_filt2$Genus != "MarianaHirondellea"
                       , ]
str(TEo_filt2)

TEo_filt2$TE_order <- factor(TEo_filt2$TE_order, levels = c("LINE", "SINE",
                                                          "LTR", "TIR", "Helitron", 
                                                          "Maverick", "Crypton", "Unknown"))

TEo_filt2$Genus <- factor(TEo_filt2$Genus, levels = c("Platorchestia","Trinorchestia", "Orchestia",
                                                      "Hyalella","Parhyale","Gammarus","Paralicella",
                                                      "Bathycallisoma","Hirondellea",
                                                      "390_flye_Hirondellea",
                                                      "394_flye_Hirondellea"))
  
#  "Hirondellea", "Bathycallisoma",
#                                                    "Paralicella", "Gammarus", "Parhyale",
#                                                    "Hyalella", "Orchestia", 
#                                                    "Trinorchestia", "Platorchestia"))
str(TEo_filt2)

#adjust coulour palette so same as repeat landscapes
cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#F0E442", "#D55E00", "#999999")
#generate the plot
TEorder_stack <- ggplot(TEo_filt2, aes(x = PercentageOfSequence, y = Genus, 
                             fill = TE_order)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "TE Order")
TEorder_stack

ggsave(TEorder_stack,
       filename = "Plots/TEorder_stackedbar_DNAsorted.png",
       bg = "transparent",
       width = 15, height = 7, dpi = 300, units = "cm", device='png')

###### Scatter mean order plot ------
sfm <- read.csv("Data/DarenSuperFamiliesMean2.csv")
str(sfm)

sfmwounk <- sfm[sfm$Superfamily != "Unknown" &
                  sfm$Superfamily != "non-TE", ]
sfmwounk$Superfamily <- factor(sfmwounk$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                                "RC"))
#1
sfmpoint <- ggplot(sfmwounk) +
  geom_point(aes(x = Superfamily, y = PercentageOfSequence,
                 colour = ID), size = 4) +
  labs(x = "TE Superfamily",
       y = "% sequence from TE") +
  scale_colour_manual(values = cbPalette) +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA))
sfmpoint
###### lollipod mean order plot ------
sfmplot2 <- ggplot(sfmwounk, aes(x = Genus, y = PercentageOfSequence)) +
  geom_point(aes(colour = Habitat), size = 7) +
  geom_segment(aes(x = Genus, xend = Genus, 
                   y = 0, yend = PercentageOfSequence,
                   colour = Habitat),
               size = 2) +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        text = element_text(size=36),
        legend.text = element_text(size=30),
        #legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA),
        legend.position = c(0.85, -0.1)) + 
  facet_wrap(~ Superfamily, scales = "free_y") + 
  labs(y = "% sequence from TE", x = "Genus")  +
  scale_colour_manual(values = cbPalette)
sfmplot2
######  stacked bar mean order plot ------
sfmte <- sfm[sfm$Superfamily != "non-TE",]
sfmte$Superfamily <- factor(sfmte$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                                "RC", "Unknown"))
sfmte$Genus <- factor(sfmte$Genus, levels = c("Shallow-water mean", "Paralicella",
                                          "Hirondellea", "Bathycallisoma"))

sfplot3 <- ggplot(sfmte, aes(x = PercentageOfSequence, y = Genus, 
                               fill = Superfamily)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette)  +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "TE Order")
sfplot3

ggsave(sfplot3,
       filename = "Plots/SFbar_Plot3.png",
       bg = "transparent",
       width = 37.8, height = 10, dpi = 300, units = "cm", device='png')

### stacked bar plot TE orders -----
order <- read.csv("Data/DarenSuperFamilies.csv")
str(order)

order2 <- order[order$Superfamily != "non-TE",]
order2$Superfamily <- factor(order2$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                          "RC", "Unknown"))
#order2$Genus <- factor(sfmte$Genus, levels = c("Shallow-water mean", "Paralicella",
#                                              "Hirondellea", "Bathycallisoma"))

ggplot(order2, aes(x = PercentageOfSequence, y = Genus, 
                             fill = Superfamily)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette)  +
  theme(text = element_text(size=36),
        legend.text = element_text(size=30),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "TE Order")

### Bathycallisoma ----
bgs <- read.csv("Data/BodyGenomeSize.csv")
str(bgs)

bgs <- bgs[bgs$Species != "Alicella gigantea", ]

ggplot(bgs) +
  geom_point(aes(x = GenomeSize, y = MaxBodyLength))

#log both
bgs <- mutate(bgs, logGS = log10(GenomeSize))
bgs <- mutate(bgs, logmbs = log10(MaxBodyLength))
str(bgs)

#mskr linear model
bgslm <- lm(logmbs ~ logGS, data = bgs)
#linearity
plot(bgslm, which = 1, add.smooth = FALSE)
#normality
plot(bgslm, which = 2)
#constant variance
plot(bgslm, add.smooth = FALSE, which = 3)

anova(bgslm)

#plot regression line
bgsplot <- ggplot(bgs, aes(x = GenomeSize, y = MaxBodyLength)) +
  geom_point() +
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth")
ggsave(bgsplot,
       filename = "Plots/GenomeSizeCalc.png",
       bg = "transparent",
       #width = 42, height = 29.7, dpi = 300, units = "cm",
       device='png')

#genome size estimate is ~14Gb 


#ggplot(bgs, aes(x = logGS, y = logmbs)) +
#  geom_point() +
#  stat_smooth(method = "lm",
#              formula = y ~ x,
#              geom = "smooth")

### Hirondellea RNA v RAD ----

#set up
hiro <- read.csv("Data/Hirondellea_RNAvRAD.csv")
str(hiro)

#remove non-TE data
hiro_2 <- hiro[hiro$Order != "non-TE" #&
                 # TEo$TE_order != "Unknown"
                 , ]

#calculate Order/TotalTEPercent * 100
## the amount of total TE that belongs to each TE order
hiro_3 <- mutate(hiro_2, newpercent = ((PercentSeq/TotalTEPercent)*100))
str(hiro_3)


hiro_3$Order <- factor(hiro_3$Order, levels = c("LINE", "SINE",
                                                            "LTR", "TIR", "Helitron", 
                                                            "Maverick", "Crypton", "Unknown"))

#adjust coulour palette so same as repeat landscapes
cbPalette2 <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#F0E442", "#D55E00", "#999999")

#non-adjusted  plot
TEorder_stack <- ggplot(hiro_3, aes(x = PercentSeq, y = SeqType, 
                                       fill = Order)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  #theme(text = element_text(size=36),
  #      legend.text = element_text(size=30),
  #      legend.background = element_rect(fill = "transparent"),
  #      plot.background = element_rect(fill='transparent', color=NA)) +
  labs(x = "% sequence from TE", fill = "TE Order")
TEorder_stack

ggsave(TEorder_stack,
       filename = "Plots/TEorder_stackedbar_DNAsorted.png",
       bg = "transparent",
       width = 15, height = 7, dpi = 300, units = "cm", device='png')

#adjusted plot
RNAvRAD <- ggplot(hiro_3, aes(x = newpercent, y = SeqType, fill = Order)) +
  geom_bar(position = "stack", stat = "identity")   +
  scale_fill_manual(values = cbPalette2)  +
  labs(x = "% total TE from TE Order", fill = "TE Order",
       y = "Sequencing Type")

ggsave(RNAvRAD,
       filename = "Plots/RNAvRAD_barplot.png",
       bg = "transparent",
       width = 15, height = 7, dpi = 300, units = "cm", device='png')
