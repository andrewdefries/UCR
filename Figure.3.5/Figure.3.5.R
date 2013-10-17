##################
library(ChemmineR)
##################
#Clickable_ArabidopsisActives.sdf provided as a record
#load, generate apset
sdfset <- read.SDFset("Clickable_ArabidopsisActives.sdf")
apset <- sdf2ap(sdfset)
#create distance matrix to cluster apset
dummy <- cmp.cluster(db=apset, cutoff=0, save.distances="distmat.rda")
load("distmat.rda")
#plot apset distance matrix as hierarchical cladogram
hc <- hclust(as.dist(distmat), method="single")
hc[["labels"]] <- cid(apset)
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=F)

