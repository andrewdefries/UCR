##################
library(ChemmineR)
##################
propma <- data.frame(MF=MF(sdfset, addH=FALSE), MW=MW(sdfset, addH=FALSE), ...
Ncharges=sapply(bonds(sdfset, type="charge"), length), atomcountMA(sdfset, ...
addH=FALSE), groups(sdfset, type="countMA"), rings(sdfset, upper=6, ...
type="count", arom=TRUE))
#add data from GetMoreProps.sh
More<-read.table(props[a])
names(More)<-c("TPSA","logP")
saved<-names(propma)
propma<-cbind(propma,More$TPSA, More$logP)
names(propma)<-c(saved,c("TPSA","logP"))
write.csv(propma, file=csv_name)
# propma is then sent for second treatment
######################
files <- list.files(recursive=TRUE, pattern = ".csv")
######################
par(mfrow=c(2,3))
######################
DoThis <- function(a){
######################
png_name<-paste(gsub(".csv","",files[a]),".png",sep="")
######################
png(file=png_name)
######################
MW <- read.csv(files[a])$MW
TPSA <- read.csv(files[a])$TPSA
logP <- read.csv(files[a])$logP
######################
library(scatterplot3d)
######################
scatterplot3d(MW,TPSA,logP, xlim=c(0,2000), ylim=c(0,800), ...
zlim=c(0,20), main=gsub(".csv","",files[a]))
######################
dev.off()
######################
}
######################
#a<-1:length(files)
a<-c(1,2,6,4,3,5)
lapply(a,DoThis)
######################

