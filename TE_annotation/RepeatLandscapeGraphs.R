#RepeatLandscapeGraphs

#06/07/23

#bins and counts generated with parseRM.sh

library(ggplot2)
library(dplyr)

# The palette with grey:
cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#CC79A7", "#999999", "#F0E442", "#D55E00")

### Test ----
aby <- read.csv("Data/AbyssorchomeneTestDivBins.csv")
str(aby)

#sort superfamily order
aby$Superfamily <- factor(aby$Superfamily, levels = c("LINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

aby_land <- ggplot(aby)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 
aby_land

filen <- "Plots/aby_Landscape.png"

ggsave(aby_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 100, dpi = 300, units = "mm", 
       device='png')

### Bathycallisoma ----
bath <- read.csv("Data/Bathycallisoma_landscapebins.csv")
str(bath)

#sort superfamily order
bath$Superfamily <- factor(bath$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

bath_land <- ggplot(bath)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/bath_Landscape.png"

ggsave(bath_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Hirondellea ----
hir <- read.csv("Data/Hirondellea_landscapebins.csv")
str(hir)

#sort superfamily order
hir$Superfamily <- factor(hir$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

hir_land <- ggplot(hir)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/hir_Landscape.png"

ggsave(hir_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Paralicella ----
####all-familiies consensus library ----
para <- read.csv("Data/Paralicella_landscapebins.csv")
str(para)

#sort superfamily order
para$Superfamily <- factor(para$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

para_land <- ggplot(para)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/para_Landscape.png"

ggsave(para_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

#### consensus library without RMod Paralicella TE ----
para_wo <- read.csv("Data/Paralicella_woPara_landscapebins.csv")
str(para_wo)

#sort superfamily order
para_wo$Superfamily <- factor(para_wo$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                        "RC", "Unknown"))

para_land_wo <- ggplot(para_wo)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/para_wo_Landscape.png"

ggsave(para_land_wo,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

#### consensus library, mask without Para and then with Para ----
para_wo_w <- read.csv("Data/Paralicella_woPara_Para_landscapebins.csv")
str(para_wo_w)

#sort superfamily order
para_wo_w$Superfamily <- factor(para_wo_w$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                              "RC", "Unknown"))

para_land_wo_w <- ggplot(para_wo_w)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/para_wo_w_Landscape.png"

ggsave(para_land_wo_w,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')


### Parhyale ----
parh <- read.csv("Data/Parhyale_landscapebins.csv")
str(parh)

#sort superfamily order
parh$Superfamily <- factor(parh$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

parh_land <- ggplot(parh)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/parh_Landscape.png"

ggsave(parh_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Hyalella ----
hya <- read.csv("Data/Hyalella_landscapebins.csv")
str(hya)

#sort superfamily order
hya$Superfamily <- factor(hya$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

hya_land <- ggplot(hya)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/hya_Landscape.png"

ggsave(hya_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Gammarus ----
gam <- read.csv("Data/Gammarus_landscapebins.csv")
str(gam)

#sort superfamily order
gam$Superfamily <- factor(gam$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

gam_land <- ggplot(gam)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/gam_Landscape.png"

ggsave(gam_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Trinorchestia ----
trin <- read.csv("Data/Trinorchestia_landscapebins.csv")
str(trin)

#sort superfamily order
trin$Superfamily <- factor(trin$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

trin_land <- ggplot(trin)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/trin_Landscape.png"

ggsave(trin_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Platorchestia ----
plat <- read.csv("Data/Platorchestia_landscapebins.csv")
str(plat)

#sort superfamily order
plat$Superfamily <- factor(plat$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "Helitron", "Unknown"))
#WITH LEGEND AND X AXIS LABEL
plat_land <- ggplot(plat)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = "% divergence to consensus",
       y = NULL,
       fill = "TE Order") +
  scale_fill_manual(values=cbPalette) +
  theme(#legend.position = "none",
        text = element_text(size=36)) 

filen <- "Plots/LEGENDplat_Landscape.png"

ggsave(plat_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 100, dpi = 300, units = "mm", 
       device='png')
#PLOT ONLY
plat_land <- ggplot(plat)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30))

filen <- "Plots/plat_Landscape.png"

ggsave(plat_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Orchestia wrong ----
orc <- read.csv("Data/Orchestia_landscapebins.csv")
str(orc)

#sort superfamily order
orc$Superfamily <- factor(orc$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

orc_land <- ggplot(orc)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/orc_Landscape.png"

ggsave(orc_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### Orchestia fixed ----
orc <- read.csv("Data/Orchestia_fixed_landscapebins.csv")
str(orc)

#sort superfamily order
orc$Superfamily <- factor(orc$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

orc_land <- ggplot(orc)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/orc_fixed_Landscape.png"

ggsave(orc_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### 390 Hirondellea ----
hir390 <- read.csv("Data/390_flye_Hirondellea-LandscapeBins.csv")
str(hir390)

#sort superfamily order
hir390$Superfamily <- factor(hir390$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                      "RC", "Unknown"))

hir390_land <- ggplot(hir390)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/Chapter3/390_flye_Landscape.png"

ggsave(hir390_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### 394 Hirondellea ----
hir394 <- read.csv("Data/394_flye_Hirondellea-LandscapeBins.csv")
str(hir394)

#sort superfamily order
hir394$Superfamily <- factor(hir394$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                            "RC", "Unknown"))

hir394_land <- ggplot(hir394)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/Chapter3/394_flye_Landscape.png"

ggsave(hir394_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')

### WG PacBio Hirondellea ----
wghir <- read.csv("Data/WG_Hirondellea_landscapebins.csv")
str(wghir)

#sort superfamily order
wghir$Superfamily <- factor(wghir$Superfamily, levels = c("LINE", "SINE", "LTR", "DNA", 
                                                            "RC", "Unknown"))

wghir_land <- ggplot(wghir)+
  geom_bar(aes(x = PercentDiv, y = Count, fill = Superfamily),
           position = "stack", stat = "identity") + 
  labs(x = NULL, y = NULL) +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "none",
        text = element_text(size=30)) 

filen <- "Plots/Chapter3/WG_PB_Hirondellea_Landscape.png"

ggsave(wghir_land,
       filename = filen,
       bg = "transparent",
       width = 300, height = 80, dpi = 300, units = "mm", 
       device='png')