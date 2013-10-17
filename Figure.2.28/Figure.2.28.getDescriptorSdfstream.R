##################
library(ChemmineR)
##################
#define function to collect descriptors
desc <- function(sdfset) {
cbind(SDFID=sdfid(sdfset),
datablock2ma(datablocklist=datablock(sdfset)),
MW=MW(sdfset),
groups(sdfset),
AP=sdf2ap(sdfset, type="character"),
rings(sdfset, type="count", upper=6, arom=TRUE)
)
}
#execute sdfstream
sdfStream(input="ZINC_Purchasible.sdf", output="ZINC_Purchasible.xls", append=FALSE, fct=desc, Nlines=1000)
#subset the sdf for compounds with terminal acetylenes
indexDF <- read.delim("ZINC_Purchasible.xls", row.names=1)
indexDFsub <- indexDF[indexDF$RCCH >= 1, ]
#subset source sdf with indexDFsub containing only the rows for compounds with RCCH>=1
read.SDFindex(file="ZINC_Purchasible.sdf", index=indexDFsub, type="file", outfile="ZINC_80K.sdf")
#This will write all molecules with RCCH>=1 to an SD file called "ZINC_80K.sdf".
#Help and comments provided by Thomas Girke

