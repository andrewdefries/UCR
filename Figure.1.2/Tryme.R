library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)  

pubChemDatabase
###############
library(ape)
library(bioassayR)
###############
FukDrugs<-function(a){
###############
OutName<-paste(PubChemIDs[a], "_activeAgainst_phylodata.rda", sep="")
###############
drugTargets <- activeTargets(pubChemDatabase, PubChemIDs[a])
###############

###############
targetSequences <- read.GenBank(row.names(drugTargets), species.names = TRUE)
###############
write.table(cbind(attr(targetSequences, "species"), names(targetSequences)), file=OutName sep="", quote=T)
###############
extdata_dir <- system.file("extdata", package="bioassayR") 
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)  
################
activeCompounds <- activeAgainst(pubChemDatabase, "166897622")
################
}
################
a<-1:length(PubChemIDs)
################
lapply(a, FukDrugs)
################


###################################################
### code chunk number 31: bioassayR.Rnw:332-334
###################################################
library(ape)
targetSequences <- read.GenBank(row.names(drugTargets), species.names = TRUE)


###################################################
### code chunk number 32: bioassayR.Rnw:338-339
###################################################
cbind(attr(targetSequences, "species"), names(targetSequences))


###################################################
### code chunk number 33: bioassayR.Rnw:354-358
###################################################
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR") 
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)  


###################################################
### code chunk number 34: bioassayR.Rnw:365-367
###################################################
activeCompounds <- activeAgainst(pubChemDatabase, "166897622")
activeCompounds[1:10,] # look at the first 10 compounds

