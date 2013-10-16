### R code from vignette source 'bioassayR.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: bioassayR.Rnw:67-69 (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R") # Sources the biocLite.R installation script.
## biocLite("bioassayR") # Installs the package.


###################################################
### code chunk number 3: bioassayR.Rnw:74-75
###################################################
library(bioassayR) # Loads the package


###################################################
### code chunk number 4: bioassayR.Rnw:77-79 (eval = FALSE)
###################################################
## library(help="bioassayR") # Lists all functions and classes 
## vignette("bioassayR") # Opens this PDF manual from R


###################################################
### code chunk number 5: bioassayR.Rnw:90-94
###################################################
library(bioassayR)
library(RSQLite)
myDatabaseFilename <- tempfile() 
mydb <- newBioassayDB(myDatabaseFilename, indexed=F)


###################################################
### code chunk number 6: bioassayR.Rnw:99-100
###################################################
addDataSource(mydb, description="PubChem Bioassay", version="unknown")


###################################################
### code chunk number 7: bioassayR.Rnw:106-108
###################################################
data(samplebioassay)
samplebioassay[1:10,] # print the first 10 scores


###################################################
### code chunk number 8: bioassayR.Rnw:114-118
###################################################
myAssay <- new("bioassay",aid="1000", source_id="PubChem Bioassay",
    assay_type="confirmatory", organism="unknown", scoring="activity rank", 
    targets="116516899", target_types="protein", scores=samplebioassay)
myAssay


###################################################
### code chunk number 9: bioassayR.Rnw:124-125
###################################################
loadBioassay(mydb, myAssay)


###################################################
### code chunk number 10: bioassayR.Rnw:131-135
###################################################
tempAssay <- getAssay(mydb, "1000") # get assay from database
dropBioassay(mydb, "1000") # delete assay from database
organism(tempAssay) <- "Streptococcus pneumonia" # update organism
loadBioassay(mydb, tempAssay)


###################################################
### code chunk number 11: bioassayR.Rnw:140-141
###################################################
addBioassayIndex(mydb)


###################################################
### code chunk number 12: bioassayR.Rnw:146-147
###################################################
mydb


###################################################
### code chunk number 13: bioassayR.Rnw:152-153
###################################################
activeTargets(mydb, 16749979)


###################################################
### code chunk number 14: bioassayR.Rnw:160-161
###################################################
queryBioassayDB(mydb, "SELECT * FROM sqlite_master WHERE type='table'")


###################################################
### code chunk number 15: bioassayR.Rnw:166-167
###################################################
queryBioassayDB(mydb, "SELECT DISTINCT(aid) FROM activity WHERE cid = '16749979'")


###################################################
### code chunk number 16: bioassayR.Rnw:172-173
###################################################
queryBioassayDB(mydb, "SELECT * FROM activity WHERE aid = '1000' LIMIT 10")


###################################################
### code chunk number 17: bioassayR.Rnw:178-179
###################################################
disconnectBioassayDB(mydb)


###################################################
### code chunk number 18: bioassayR.Rnw:182-184
###################################################
# delete temporary database
unlink(myDatabaseFilename)


###################################################
### code chunk number 19: bioassayR.Rnw:192-196
###################################################
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
assayDescriptionFile <- file.path(extdata_dir, "exampleAssay.xml")
activityScoresFile <- file.path(extdata_dir, "exampleScores.csv")


###################################################
### code chunk number 20: bioassayR.Rnw:202-204
###################################################
myDatabaseFilename <- tempfile()
mydb <- newBioassayDB(myDatabaseFilename, indexed=F)


###################################################
### code chunk number 21: bioassayR.Rnw:208-209
###################################################
addDataSource(mydb, description="PubChem Bioassay", version="unknown")


###################################################
### code chunk number 22: bioassayR.Rnw:216-218
###################################################
myAssay <- parsePubChemBioassay("1000", activityScoresFile, assayDescriptionFile)
myAssay


###################################################
### code chunk number 23: bioassayR.Rnw:223-224
###################################################
loadBioassay(mydb, myAssay)


###################################################
### code chunk number 24: bioassayR.Rnw:229-230
###################################################
addBioassayIndex(mydb)


###################################################
### code chunk number 25: bioassayR.Rnw:235-238
###################################################
queryBioassayDB(mydb, "SELECT * FROM activity LIMIT 10")
queryBioassayDB(mydb, "SELECT * FROM assays")
queryBioassayDB(mydb, "SELECT * FROM targets LIMIT 10")


###################################################
### code chunk number 26: bioassayR.Rnw:243-244
###################################################
disconnectBioassayDB(mydb)


###################################################
### code chunk number 27: bioassayR.Rnw:247-249
###################################################
# delete temporary database
unlink(myDatabaseFilename)


###################################################
### code chunk number 28: bioassayR.Rnw:254-298 (eval = FALSE)
###################################################
## # this is code for building the example database used here- it should not
## # be visible to the reader in the final PDF
## library(bioassayR)
## pubChemDatabase <- connectBioassayDB("working/bioassayDatabase.sqlite")
## sampleDB <- newBioassayDB("src/bioassayR/inst/extdata/sampleDatabase.sqlite", indexed=F)
## addDataSource(sampleDB, description="bioassayR_testdata", version="unknown")
## 
## # add activity rows
## activityRows <- queryBioassayDB(pubChemDatabase, "SELECT * FROM activity WHERE cid = '2244'")
## con <- slot(sampleDB, "database")
## sql <- paste("INSERT INTO activity VALUES ($aid, $cid, $sid, $activity, $score)", sep="")
## dbBeginTransaction(con)
## dbGetPreparedQuery(con, sql, bind.data = activityRows)
## dbCommit(con)
## 
## # add assay ids and targets
## for(aid in activityRows[,1]){
##     assay <- queryBioassayDB(pubChemDatabase, paste("select * from assays where aid =", aid))
##     target <- queryBioassayDB(pubChemDatabase, paste("select * from targets where aid =", aid))
##     if(nrow(target) == 1){
##         addAssayTarget(sampleDB, aid = aid, target=target$target, target_type=target$target_type)
##     }
##     addBioassay(sampleDB, source="bioassayR_testdata", aid=aid, assay_type=assay$assay_type, organism=assay$organism, scoring=assay$scoring)
## }
## 
## # load activity data for target 166897622
## assays <- queryBioassayDB(pubChemDatabase, "SELECT aid FROM targets WHERE target = '166897622'")[[1]]
## for(aid in assays[! assays %in% activityRows[,1]]){
##     assay <- queryBioassayDB(pubChemDatabase, paste("select * from assays where aid =", aid))
##     target <- queryBioassayDB(pubChemDatabase, paste("select * from targets where aid =", aid))
##     if(nrow(target) == 1){
##         addAssayTarget(sampleDB, aid = aid, target=target$target, target_type=target$target_type)
##     }
##     addBioassay(sampleDB, source="bioassayR_testdata", aid=aid, assay_type=assay$assay_type, organism=assay$organism, scoring=assay$scoring)
## 
##     activityRows <- queryBioassayDB(pubChemDatabase, paste("SELECT * FROM activity WHERE aid =", aid))
##     con <- slot(sampleDB, "database")
##     sql <- paste("INSERT INTO activity VALUES ($aid, $cid, $sid, $activity, $score)", sep="")
##     dbBeginTransaction(con)
##     dbGetPreparedQuery(con, sql, bind.data = activityRows)
##     dbCommit(con)
## }
## 
## disconnectBioassayDB(sampleDB)


###################################################
### code chunk number 29: bioassayR.Rnw:313-317
###################################################
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)  


###################################################
### code chunk number 30: bioassayR.Rnw:324-326
###################################################
drugTargets <- activeTargets(pubChemDatabase, "2244")
drugTargets


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


###################################################
### code chunk number 35: bioassayR.Rnw:376-379
###################################################
selectiveCompounds <- selectiveAgainst(pubChemDatabase, "166897622", 
    maxCompounds = 10, minimumTargets = 1)
selectiveCompounds


###################################################
### code chunk number 36: bioassayR.Rnw:389-391
###################################################
library(ChemmineR)
structures <- getIds(as.numeric(row.names(selectiveCompounds)))


###################################################
### code chunk number 37: plotstruct
###################################################
plot(structures[1:4], print=FALSE) # Plots structures to R graphics device


###################################################
### code chunk number 38: bioassayR.Rnw:407-417
###################################################
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR") 
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
sampleDB <- connectBioassayDB(sampleDatabasePath)  
myDatabaseFilename <- tempfile() 
mydb <- newBioassayDB(myDatabaseFilename, indexed=F)
addDataSource(mydb, description="bioassayR_testdata", version="unknown")
loadBioassay(mydb, getAssay(sampleDB, 53224))
loadBioassay(mydb, getAssay(sampleDB, 53211))
loadBioassay(mydb, getAssay(sampleDB, 207758))


###################################################
### code chunk number 39: bioassayR.Rnw:422-424
###################################################
myMatrix <- activityMatrix(mydb)
myMatrix


###################################################
### code chunk number 40: bioassayR.Rnw:430-431
###################################################
myMatrix[is.na(myMatrix)] <- 0


###################################################
### code chunk number 41: bioassayR.Rnw:438-439
###################################################
clusterResults <- hclust(dist(myMatrix), method="average")


###################################################
### code chunk number 42: clusterResult
###################################################
plot(clusterResults)


###################################################
### code chunk number 43: bioassayR.Rnw:447-449
###################################################
disconnectBioassayDB(mydb)
disconnectBioassayDB(sampleDB)


###################################################
### code chunk number 44: bioassayR.Rnw:452-454
###################################################
# delete temporary database
unlink(myDatabaseFilename)


###################################################
### code chunk number 45: sessionInfo
###################################################
toLatex(sessionInfo())


