## Creating a heatmap of TE family versus Amphipod species

#27/10/23

# UPDATE 21/02/24 #
# 'Hirondellea' is an assembly of H. dubia and H. gigas. 
# New versions are 'H.gigas.csv' (Mariana) and 'H_dubia.csv' (Kermadec and NHT)
# Update script accordingly

### set up -----

# load packages
library(tidyverse)
library(hrbrthemes)

# Clear global environment
rm(list = ls())

#set working directory
setwd("H:/PhD_Stuff/R/Data/TEfamilies")

#read in data
Hirondellea <- read.csv("Hirondellea.csv")
Paralicella <- read.csv("Paralicella.csv")
Bathycalli <- read.csv("Bathycallisoma.csv")
Gammarus <- read.csv("Gammarus.csv")
Hyalella <- read.csv("Hyalella.csv")
Orchestia <- read.csv("Orchestia.csv")
Parhyale <- read.csv("Parhyale.csv")
Platorchestia <- read.csv("Platorchestia.csv")
Trinorchesta <- read.csv("Trinorchestia.csv")

#check read successfully
str(Hirondellea)
str(Paralicella)
str(Bathycalli)
str(Gammarus)
str(Hyalella)
str(Orchestia)
str(Parhyale)
str(Platorchestia)
str(Trinorchesta)

#number of rows per dataset #from str()
76+39+78+86+80+91+92+83+81 #706

### Merge spreadsheets ----
amphi_merged <- do.call("rbind", list(Hirondellea, Paralicella, Bathycalli, Gammarus, Hyalella, Orchestia, Parhyale,
                                      Platorchestia, Trinorchesta))
str(amphi_merged) #number rows after merging 706

### Remove all columns bar Species, TE family and %bp ----
amphi_merged_percent <- subset(amphi_merged, select = -c(nt_masked.minus.double, FYI.nt_masked_double))
str(amphi_merged_percent)

### Generate rows for missing families -----
# How many distinct family values are there? (there may not be one Genus that has every single one of each family so 
# simply asking the max number of family in a Genus may not give you the number of unique family in the df)
n_distinct(amphi_merged_percent$family)
# store a list of the unique family in a vector
fam_list <- unique(amphi_merged_percent$family)

#repeat for spp
n_distinct(amphi_merged_percent$Genus)
spp_list <- unique(amphi_merged_percent$Genus)

# make vector repeating the spp values times the number of family
df3 <- rep(spp_list, each = 99) 

# make vector repeating the fam values times the number of spp
df2 <- rep(fam_list, times = 9)

# combine the vectors
df4 <- as.data.frame(cbind(df3, df2))
df4 <- dplyr::rename(df4, Genus = df3)
df4 <- dplyr::rename(df4, family = df2)

# join the new ideal df4 with the original data df
df5 <- left_join(df4, amphi_merged_percent, by = c("Genus", "family")) # i think merge reorders rows 

### Replace NA with 0 ----
df6 <- replace(df5, is.na(df5), 0)
str(df6)

### Remove LINE- and DNA- naming's ----
df6$family <- gsub("LINE-", "", as.character(df6$family)) 
df6$family <- gsub("DNA-", "", as.character(df6$family))
df7 <- aggregate(. ~ Genus + family, data = df6, sum)
str(df7)

### Add TE orders to dataframe ----

#add in TE order classifications
new_fam_list <- unique(df7$family)
#export unique TE family list
write.csv(new_fam_list, "../Daren_unique_TEfamilies3.csv", row.names=FALSE)  
#add classifications using my xlsx TE classification guide, see lit. rev.

fam_order <- read.csv("../Daren_unique_TEfamilies3.csv") #read in new table
fam_order <- dplyr::rename(fam_order, family = x) #corrent name on family column
str(fam_order)

#join the new table onto df5
df8 <- left_join(df7, fam_order, by = c("family"))
str(df8)

### arrange variable orders ----

#sort by genus
df8$Genus <- factor(df8$Genus, levels = c("Hirondellea", "Bathycallisoma",
                                            "Paralicella", "Gammarus", "Parhyale",
                                            "Hyalella","Orchestia", 
                                            "Trinorchestia", "Platorchestia"))

# opposite order, if needed
#"Platorchestia","Trinorchestia", "Orchestia",
#                                       "Hyalella","Parhyale","Gammarus","Paralicella",
#                                      "Bathycallisoma","Hirondellea"))

#sort by order
df8$Order <- factor(df8$Order, levels = c("LINE", "SINE", "LTR", "TIR", "Helitron",
                                            "Maverick", "Crypton", "Unknown"))

# sort families into order with unclassified at top
####### press here to collapse ----
#list made manually in xlsx, then added punctuation, removed tabs in word
df8$family <- factor(df8$family, levels = c("Tad1",
                                            "RTE-X",
                                            "RTE-RTE",
                                            "RTE-BovB",
                                            "RTE",
                                            "Rex-Babar",
                                            "R2-NeSL",
                                            "R2-Hero",
                                            "R2",
                                            "R1-LOA",
                                            "R1",
                                            "Proto2",
                                            "Penelope",
                                            "L2",
                                            "L1-Tx1",
                                            "L1-dep",
                                            "L1",
                                            "I-Jockey",
                                            "I",
                                            "Dong-R4",
                                            "CRE-Odin",
                                            "CRE",
                                            "CR1-Zenon",
                                            "CR1",
                                            "LINE",
                                            "tRNA-V-CR1",
                                            "tRNA-Deu-RTE",
                                            "tRNA-Deu-L2",
                                            "tRNA-Deu",
                                            "tRNA-Core-RTE",
                                            "tRNA",
                                            "MIR",
                                            "5S-Deu-L2",
                                            "SINE",
                                            "Pao",
                                            "Ngaro",
                                            "Gypsy",
                                            "ERVL-MaLR",
                                            "ERVL",
                                            "ERVK",
                                            "ERV1",
                                            "DIRS",
                                            "Copia",
                                            "LTR",
                                            "Zisupton",
                                            "Zator",
                                            "TcMar-Tigger",
                                            "TcMar-Tc4",
                                            "TcMar-Tc2",
                                            "TcMar-Tc1",
                                            "TcMar-Stowaway",
                                            "TcMar-Pogo",
                                            "TcMar-Mariner",
                                            "TcMar-m44",
                                            "TcMar-ISRm11",
                                            "TcMar-Fot1",
                                            "TcMar",
                                            "Sola-2",
                                            "Sola-1",
                                            "PiggyBac",
                                            "PIF-ISL2EU",
                                            "PIF-Harbinger",
                                            "P",
                                            "MULE-NOF",
                                            "MULE-MuDR",
                                            "Merlin",
                                            "Kolobok-Hydra",
                                            "Kolobok-E",
                                            "IS3EU",
                                            "hAT-Tip100",
                                            "hAT-Tag1",
                                            "hAT-Pegasus",
                                            "hAT-hobo",
                                            "hAT-hATx",
                                            "hAT-hATm",
                                            "hAT-hAT5",
                                            "hAT-hAT19",
                                            "hAT-Charlie",
                                            "hAT-Blackjack",
                                            "hAT-Ac",
                                            "hAT",
                                            "Ginger-2",
                                            "Ginger-1",
                                            "Dada",
                                            "CMC-Transib",
                                            "CMC-EnSpm",
                                            "CMC-Chapaev-3",
                                            "Academ-1",
                                            "DNA",
                                            "Helitron-2",
                                            "Helitron",
                                            "Crypton-V",
                                            "Crypton-H",
                                            "Maverick",
                                            "Unknown"))






### ggplot heat map ----
str(df8)
#make heatmap
heatmap <- ggplot(df8, aes(y = family, x = Genus, fill = X._masked)) +
  geom_tile() +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        strip.text.y = element_text(angle = 0))+
  facet_grid(Order~., scales="free_y", space = "free") +
  scale_fill_distiller(palette = "Blues", direction = -1) +
  labs(y = "TE Family", fill = "% Masked")
heatmap

ggsave(heatmap,
       filename = "../../Plots/TEfamily_heatmap_daren3.png",
       bg = "transparent",
       width = 15, height = 30, dpi = 300, units = "cm", device='png')



### Old code versions ----

#### AT THIS POINT GO TO SECTION 'Separate DNA transposons'
### Unsorted ----
#add in TE order classifications
write.csv(fam_list, "../Daren_unique_TEfamilies.csv", row.names=FALSE) #export unique TE family list 
    #add classifications using my xlsx TE classification guide, see lit. rev.
fam_order <- read.csv("../Daren_unique_TEfamilies.csv") #read in new table
fam_order <- subset(fam_order, select = -c(All)) #remove empty column
fam_order <- dplyr::rename(fam_order, family = x) #corrent name on family column
str(fam_order)

#join the new table onto df5
df5b <- left_join(df5, fam_order, by = c("family"))

### Replace NA with 0 ---
df6 <- replace(df5b, is.na(df5b), 0)

### Change tidydf to matrix -----
m3 <- acast(df6, Genus~family, value.var = "X._masked")

# Default Heatmap
heatmap(m3)


### ggplot heat map ----

#sort by genus
df6$Genus <- factor(df6$Genus, levels = c("Hirondellea", "Bathycallisoma",
                                          "Paralicella", "Gammarus", "Parhyale",
                                          "Hyalella","Orchestia", 
                                          "Trinorchestia", "Platorchestia"))
  
  #"Platorchestia","Trinorchestia", "Orchestia",
   #                                       "Hyalella","Parhyale","Gammarus","Paralicella",
    #                                      "Bathycallisoma","Hirondellea"))

#make heatmap
heatmap <- ggplot(df6, aes(y = family, x = Genus, fill = X._masked)) +
  geom_tile() +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        strip.text.y = element_text(angle = 0))+
  facet_grid(Order~., scales="free_y", space = "free") +
  scale_fill_distiller(palette = "Blues", direction = 1) +
  labs(y = "TE Family", fill = "% Masked")
heatmap

ggsave(heatmap,
       filename = "../../Plots/TEfamily_heatmap_daren.png",
       bg = "transparent",
       width = 15, height = 30, dpi = 300, units = "cm", device='png')




### Separate DNA transposons ----
#add in TE order classifications
#write.csv(fam_list, "../Daren_unique_TEfamilies.csv", row.names=FALSE) #export unique TE family list 
#add classifications using my xlsx TE classification guide, see lit. rev.
fam_order <- read.csv("../Daren_unique_TEfamilies2.csv") #read in new table
fam_order <- subset(fam_order, select = -c(All)) #remove empty column
fam_order <- dplyr::rename(fam_order, family = x) #corrent name on family column
str(fam_order)

#join the new table onto df5
df5c <- left_join(df5, fam_order, by = c("family"))

##### Replace NA with 0 ----
df6b <- replace(df5c, is.na(df5c), 0)
str(df6b)

write.csv(df6b, "../Daren_TEfamilies_combined.csv", row.names = F)


### RESUMING ----

setwd("H:/PhD_Stuff/R")
df6b <- read.csv("Data/Daren_TEfamilies_combined.csv")
str(df6b)

#### correct row names ----
df6b$family <- gsub("LINE-", "", as.character(df6b$family)) 
df6b$family <- gsub("DNA-", "", as.character(df6b$family))
df7 <- aggregate(. ~ Genus + family, data = df6b, sum)

##### ggplot heat map ----

#sort by genus
df6b$Genus <- factor(df6b$Genus, levels = c("Hirondellea", "Bathycallisoma",
                                          "Paralicella", "Gammarus", "Parhyale",
                                          "Hyalella","Orchestia", 
                                          "Trinorchestia", "Platorchestia"))

#"Platorchestia","Trinorchestia", "Orchestia",
#                                       "Hyalella","Parhyale","Gammarus","Paralicella",
#                                      "Bathycallisoma","Hirondellea"))


df6b$Order <- factor(df6b$Order, levels = c("LINE", "SINE", "LTR", "TIR", "Helitron",
                                            "Maverick", "Crypton", "Unknown"))
#make heatmap
heatmap <- ggplot(df6b, aes(y = family, x = Genus, fill = X._masked)) +
  geom_tile() +
  theme(axis.text.x = element_text(angle = 90, vjust=.5, hjust=1),
        strip.text.y = element_text(angle = 0))+
  facet_grid(Order~., scales="free_y", space = "free") +
  scale_fill_distiller(palette = "Blues", direction = 1) +
  labs(y = "TE Family", fill = "% Masked")
heatmap

ggsave(heatmap,
       filename = "../../Plots/TEfamily_heatmap_daren2.png",
       bg = "transparent",
       width = 15, height = 30, dpi = 300, units = "cm", device='png')

### Correcting Family naming's ----

#problem orders
#1: remove these phrases from the column family:"LINE-", "DNA-"
#2: merge rows where the family name is the same, and sum up values from the X._masked column for these rows

### fail ----
m1<-pivot_wider(df6, names_from = family, values_from = X._masked)
m2 <- data.frame(matrix(unlist(m1), nrow = length(m1), byrow = T), stringsAsFactors = FALSE)
m2 <- data.frame(t(m2[]))
#m1 <- as.matrix(with(df6, sparseMatrix(Genus, family, x="X._masked")))
to_matrix = function(tbl, rownames = NULL){
  
  tbl %>%
    {
      if(
        !tbl %>% 
        { if(!is.null(rownames)) (.) %>% dplyr::select(- contains(rownames)) else (.) } %>%
        dplyr::summarise_all(class) %>% 
        tidyr::gather(variable, class) %>%
        pull(class) %>% unique %>% identical("numeric")
      ) warning("to_matrix says: there are NON-numerical columns, the matrix will NOT be numerical")
      
      (.)
      
    } %>%
    as.data.frame() %>%
    { 
      if(!is.null(rownames)) 
        (.) %>% 
        magrittr::set_rownames(tbl %>% pull(!!rownames)) %>%
        dplyr::select(- !!rownames)
      else (.) 
    } %>%
    as.matrix()
}
m2 <- df6 %>% as_tibble() %>% to_matrix()

#get list of all families, one occurrence each
uniq_families <- unique(amphi_merged_percent$family)#99 unique families
unique(amphi_merged_percent$Genus)
#build empty matrix
m1 <- matrix(, nrow =9, ncol = 99, dimnames = list(
  c("Hirondellea"    ,"Paralicella"    ,"Bathycallisoma", "Gammarus", "Hyalella", "Orchestia",     
    "Parhyale"    ,   "Platorchestia" , "Trinorchestia"), 
       c("hAT-hAT19", "LTR", "TcMar-m44","Ginger-2","MULE-NOF", "Ngaro",         
         "Copia",          "R1-LOA"         ,"L1"             ,"RTE-X"          ,"MULE-MuDR"      ,"CRE"    ,       
         "Merlin",         "Pao"            ,"Zisupton"       ,"hAT-Tip100"     ,"DNA-TcMar"      ,"Rex-Babar",     
         "Kolobok-Hydra",  "hAT"            ,"DNA"            ,"LINE-CR1"       ,"PiggyBac"       ,"R2-NeSL"   ,    
         "Penelope",       "Dong-R4"        ,"CRE-Odin"       ,"Proto2"         ,"Ginger-1"       ,"CMC-EnSpm"  ,   
         "P",              "TcMar-ISRm11"   ,"Unknown"        ,"RTE"            ,"L1-dep"         ,"hAT-Charlie" ,  
         "Sola-1"         ,"hAT-Blackjack"  ,"RTE-RTE"        ,"Academ-1"       ,"RTE-BovB"       ,"DNA-hAT"      , 
         "DIRS"           ,"Crypton-H"      ,"hAT-hAT5"       ,"L1-Tx1"         ,"LINE-RTE"       ,"CMC-Transib"   ,
         "MIR"            ,"ERVK"           ,"PIF-Harbinger"  ,"hAT-Ac"         ,"R1"             ,"I"            , 
         "TcMar-Mariner"  ,"Maverick"       ,"TcMar-Tc1"      ,"CMC-Chapaev-3"  ,"CR1-Zenon"      ,"I-Jockey"     , 
         "TcMar-Fot1"     ,"CR1"            ,"Sola-2"         ,"Gypsy"          ,"TcMar-Pogo"     ,"Tad1"         , 
         "tRNA-Core-RTE"  ,"TcMar-Tigger"   ,"LINE"           ,"hAT-hATx"       ,"Dada"           ,"hAT-hATm"     , 
         "hAT-Tag1"       ,"L2"             ,"Helitron"       ,"ERV1"           ,"R2"             ,"hAT-hobo"     , 
         "tRNA-Deu-L2"    ,"IS3EU"          ,"tRNA"           ,"Zator"          ,"TcMar-Stowaway" ,"hAT-Pegasus"  , 
         "SINE"           ,"Kolobok-E"      ,"R2-Hero"        ,"tRNA-V-CR1"     ,"Helitron-2"     ,"5S-Deu-L2"    , 
         "LINE-I"         ,"ERVL-MaLR"      ,"PIF-ISL2EU"     ,"Crypton-V"      ,"TcMar-Tc2"      ,"tRNA-Deu-RTE" , 
         "ERVL"           ,"tRNA-Deu"       ,"TcMar-Tc4" )))

#fill in empty matrix (m1)
for (i in 1:nrow(m1)){

  
  for(j in 1:nrow(amphi_merged)){
  # run through all rows
  # read in the first column
    
    
    if(amphi_merged[j, 2] == m1[i, 1])
      
      m1[j, 1] 
      
      
    
    
  }
  
  
}





# build matrix
group_by()
amphi_matrix <- as.matrix(amphi_merged_percent)

# Default Heatmap
heatmap(amphi_matrix)

str(mtcars)
# The mtcars dataset:
data <- as.matrix(mtcars)

# Default Heatmap
heatmap(data)
