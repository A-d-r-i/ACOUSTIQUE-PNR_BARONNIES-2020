library(parallel)
soundRep<-"../sound/"
ResultRep<-"../result/"
ListSound<-dir(soundRep)

#### PARALLELE ####
no_cores<-detectCores()
c2<-makeCluster(no_cores)

parLapply(c2,ListSound, function(x){
  
  library(tuneR)
  library(seewave)
  
  source("AcouIndexAlpha.r")

  soundRep<-"../sound/"
  ResultRep<-"../result/"
  ListSound<-dir(soundRep)
  
  TableTotal<-NULL
  
  a=0
  b=1
  for (i in 1: 6)
  {
    wave<-readWave(paste(soundRep,x, sep="/"),from=a,to=b,units="minutes")
    Result<-AcouIndexAlpha(wave, stereo=FALSE, min_freq = 1000, max_freq = 22000,anthro_min = 300,
                           anthro_max = 2000,bio_min=2000,bio_max=18000, wl=512, j=5,
                           AcouOccupancy=FALSE,Bioac=TRUE,Hf=FALSE,Ht=FALSE,H=FALSE,ACI=TRUE,
                           AEI_villa=FALSE,M=FALSE,NDSI=TRUE,ADI=FALSE,NP=TRUE)
    
    Result$Mono_left$ID<-paste(x,i, sep="_")
    TableTotal<-rbind(TableTotal,Result$Mono_left)
    a=a+10
    b=b+10
  } 
  

  
  write.table(TableTotal,file=paste(ResultRep,"/",x,".csv", sep=""), sep=";", row.names = F)
  
})
