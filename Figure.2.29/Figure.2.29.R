##################
library(ChemmineR)
##################
#Clickable.sdf provided as a record for the 4,002 compounds in the 
#clickable collection of terminal acetylenes
#load sdfset and create apset for clustering
sdfset <- read.SDFset("Clickable.sdf")
apset <- sdf2ap(sdfset)
#cluster apset
clusters <- cmp.cluster(apset, cutoff = c(0.7))
#embed clusters in a 3-dimensional space based on apset
coord <- cluster.visualize(apset, clusters, size.cutoff=1, dimensions=3,
quiet=TRUE)
#set ranges for colors
coord_alpha <- coord[1:2769,1:3]
coord_beta <- coord[2770:4002,1:3]
#############
library(rgl)
#############
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col=’black’); title3d("", "", "", "", "", col=’black’); bg3d("white")
############
rgl.snapshot("coord_alphaVsbeta.png")
############
rgl.close()
############

