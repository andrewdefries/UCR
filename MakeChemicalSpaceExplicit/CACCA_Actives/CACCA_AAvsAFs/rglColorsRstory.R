
##########################
load("CACCA_RH_coord.rda")

ArabidopsisActives<-read.table("Actives")

AA_AFs <-read.table("AA_AFs")

CACCA_AFs <-read.table("CACCA_AFs")

RaikhelActives <-read.table("RaikhelActives")

AA<- coord[rownames(coord)%in%ArabidopsisActives[,1],]

AA_AFs<- coord[rownames(coord)%in%AA_AFs[,1],]

CACCA_AFs<-coord[rownames(coord)%in%CACCA_AFs[,1],]

RaikhelActives<-coord[rownames(coord)%in%RaikhelActives[,1],]


############

#write.table(ActivesCoord, #file="TriposActivesCoord4rgl",sep=" ",quote=F)
#write.table(InActivesCoord, #file="TriposInActivesCoord4rgl",sep=" ",quote=F)


coord_alpha <-AA

########

library(rgl)
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col='black'); title3d("", "", "", "", "", col='black'); bg3d("white") # To save a snapshot of the graph, one can use the command 

rgl.snapshot("CACCA_AAs.png")
rgl.close()
################


coord_beta <-CACCA_AFs

########

library(rgl)
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord[,1], coord[,2], coord[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col='black'); title3d("", "", "", "", "", col='black'); bg3d("white") # To save a snapshot of the graph, one can use the command 

rgl.snapshot("CACCA_AFs.png")
rgl.close()
################


########

library(rgl)
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.005, color="red", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="black", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col='black'); title3d("", "", "", "", "", col='black'); bg3d("white") # To save a snapshot of the graph, one can use the command 

rgl.snapshot("AFs_in_CACCA.png")
rgl.close()
################


coord_beta<-AA_AFs

########

library(rgl)
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="gray", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.025, color="green", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col='black'); title3d("", "", "", "", "", col='black'); bg3d("white") # To save a snapshot of the graph, one can use the command 

rgl.snapshot("AA_AFs_in_CACCA.png")
rgl.close()
################

coord_alpha<-coord
coord_beta<-RaikhelActives

########

library(rgl)
rgl.open(); offset <- 50; par3d(windowRect=c(offset, offset, 640+offset, 640+offset))
rm(offset); rgl.clear(); rgl.viewpoint(theta=45, phi=30, fov=60, zoom=1)
spheres3d(coord_alpha[,1], coord_alpha[,2], coord_alpha[,3], radius=0.005, color="gray", alpha=1, shininess=20); aspect3d(1, 1, 1)
spheres3d(coord_beta[,1], coord_beta[,2], coord_beta[,3], radius=0.015, color="orange", alpha=1, shininess=20); aspect3d(1, 1, 1)
axes3d(col='black'); title3d("", "", "", "", "", col='black'); bg3d("white") # To save a snapshot of the graph, one can use the command 

rgl.snapshot("RaikhelActives_CACCA.png")
rgl.close()
################




