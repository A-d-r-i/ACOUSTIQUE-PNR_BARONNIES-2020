setwd("G:/STAGE/4-ANALYSES/3-ANALYSES_DONNEES")

library(data.table)
library(tidyverse)

TC<-"oui" #si la table complète n'est pas existante, écrire "non"

#### CREATION DE LA TABLE COMPLETE ####
if (TC=="non") {
setwd("G:/STAGE/3-DONNEES/PROTOCOLE_1/2-INDICES_CLUSTER")
data_1<-list.files(pattern = "*.csv") %>% map_df(~fread(.))
data_sep1<-separate(data = data_1, col = ID, 
                    into = c("CODE_SITE","SM4_NUM","DATE","HEURE","SEQ"), sep = "_")
data_sep1$HEURE<-gsub('.wav','',data_sep1$HEURE)
data<-data_sep1
data$DISTANCE<-data$CODE_SITE
data$DISTANCE<-gsub('[A-Z]','', data$DISTANCE)
data$DISTANCE<-gsub('2','200',data$DISTANCE)
data$DISTANCE<-gsub('6','600',data$DISTANCE)

write.table(data, "G:/STAGE/4-ANALYSES/3-ANALYSES_DONNEES/TABLE_COMPLETE_INDICES.csv", sep=";", 
            row.names = F)
}
#### ANALYSES SUR TABLE COMPLETE ####
rm(list=ls())

setwd("G:/STAGE/4-ANALYSES/3-ANALYSES_DONNEES")

data<-read.table("TABLE_COMPLETE_INDICES.csv", h=T, sep=";")
#data$HEURE<-gsub("140001","140000",data$HEURE)
data200<-subset(data,data$DISTANCE=="200")
data600<-subset(data,data$DISTANCE=="600")

x11()
par(mfrow=c(2,1))
boxplot(data200$Bioac_left~data200$HEURE)
boxplot(data600$Bioac_left~data600$HEURE)

boxplot(data200$Bioac_left)
boxplot(data600$Bioac_left)