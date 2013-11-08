library(ChemmineR)

load("CACCA_RH_apset.rda")
load("CACCA_RH_sdfset.rda")
load("CACCA_RH_coord.rda")


####

blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

blockmatrix[,4]<-gsub("\\s__\\s","",blockmatrix[,4])

blockmatrix[,4]<-gsub("_","",blockmatrix[,4])

datablock(sdfset)<-blockmatrix

blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

cid(sdfset)<-datablocktag(sdfset,tag="Click_ID")

#############

rownames(coord)<-cid(sdfset)

save(coord,file="CACCA_RH_coord.rda",compress=T)

load("CACCA_RH_coord.rda")


######

sdfset<-read.SDFset("CACCA_Halo_Antifungals_June08.sdf")


####

blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

blockmatrix[,2]<-gsub("\\s__\\s","",blockmatrix[,2])

blockmatrix[,2]<-gsub("_","",blockmatrix[,2])

blockmatrix[,4]<-gsub("\\s__\\s","",blockmatrix[,4])

blockmatrix[,7]<-gsub("\\s__\\s","",blockmatrix[,7])

blockmatrix[,8]<-gsub("\\s__\\s","",blockmatrix[,8])

datablock(sdfset)<-blockmatrix

blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))

cid(sdfset)<-datablocktag(sdfset,tag="Click ID")

#############

write.table(cid(sdfset),file="CACCA_AFs")

AA_AFs<-sdfset[datablocktag(sdfset,tag="Plant Activity")==1]

cid(AA_AFs)

write.table(cid(AA_AFs),file="AA_AFs")






