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
  
    wave<-readWave(paste(soundRep,x, sep="/"),from=0,to=1,units="minutes")
    Result<-AcouIndexAlpha(wave, stereo=FALSE, min_freq = 1000, max_freq = 22000,anthro_min = 300,
                           anthro_max = 2000,bio_min=2000,bio_max=18000, wl=512, j=5,
                           AcouOccupancy=FALSE,Bioac=TRUE,Hf=FALSE,Ht=FALSE,H=FALSE,ACI=TRUE,
                           AEI_villa=FALSE,M=FALSE,NDSI=TRUE,ADI=FALSE,NP=TRUE)$Mono_left
    
    #write.table(TableTotal,file=paste(ResultRep,"/",x,".csv", sep=""), sep=";", row.names = F)
    Result$ID<-x
    save(Result, file=paste(ResultRep,"/",x,".Rdata", sep=""))
  
})
