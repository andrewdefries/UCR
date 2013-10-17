##################
library(ChemmineR)
library(fmcsR)
##################
files <- list.files(recursive=FALSE, pattern=".sdf")
##################
A <-c(2,3,2,2,2,2,3,1,1,3)
B <-c(3,3,3,3,3,3,3,4,4,3)
##################
#CladeSelection <-c("B","C","D","E","Gi","Gii", "I", "Lii", "Li", "M", "N")
CladeSelection <-c("CladeB.sdf","CladeC.sdf", "CladeD.sdf", "CladeE.sdf", ...
"CladeGi.sdf", "CladeGii.sdf", "CladeI.sdf", "CladeLii.sdf", "CladeLi.sdf", ...
"CladeM.sdf", "CladeN.sdf", "CladeO.sdf", "CladeP.sdf")
##################
DoThis <- function(a){
##################
name <- gsub(".sdf", "", CladeSelection[a])
png_name <- paste(name, "_hclust.png", sep="")
png_name2 <- paste(name, "_SAR.png", sep="")
table_name <- paste(name, "_SAR.txt", sep="")
##################
png(file=png_name, width=800, height=600, units="px")
##################
sdfset <- read.SDFset(CladeSelection[a])
##################
blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))
blockmatrix[,4]<-gsub("\\s__","",blockmatrix[,4])
IDs<-blockmatrix[,4]
blockmatrix[,4]<-gsub("CLK","",blockmatrix[,4])
blockmatrix[,4]<-gsub("_","",blockmatrix[,4])
datablock(sdfset)<-blockmatrix
blockmatrix <-datablock2ma(datablocklist=datablock(sdfset))
##################
cid(sdfset)<-datablocktag(sdfset,tag="Click_ID")
##################
d <- sapply(cid(sdfset), function(x)
fmcsBatch(sdfset[x], sdfset, au=0, bu=0,
matching.mode="aromatic")[,"Overlap_Coefficient"])
##################
##################
write.table(round(d*100), file=table_name, sep=" & ", quote=FALSE)
##################
hc <- hclust(as.dist(1-d), method="complete")
hc[["labels"]] <- cid(sdfset)
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE, main=name)
dev.off()
##################
printZ<-LETTERS[1:length(A)]
printZ <- paste(printZ, ". CLK", cid(sdfset), sep="")
##################
png(file=png_name2, width=1024, height=768, units = "px")
plot(sdfset, griddim=c(A[a],B[a]), print_cid=printZ)
dev.off()
}
##################
a <- 1:length(CladeSelection)
##################
lapply(a, DoThis)
##################

