library(coda)
args <- commandArgs(trailingOnly = TRUE)
fname <- args[1]
#Read data
#
data <- read.table(fname, header= T)
start<-floor(0.1*length(data$Sample))
end<-length(data$Sample)
data<-data[-(1:start),]
#ESS
#
ESS<-as.data.frame(effectiveSize((as.mcmc(data[2:length(data)]))))
names(ESS)<-"Effective Samples Size"
returnThis<-paste0(row.names(ESS)[which(ESS < 200 & ESS > 0)],"=",ESS[which(ESS < 200 & ESS > 0),])
#return
returnThis
#write
write.table(ESS, file=paste0(fname,"_ESS.txt"), sep="\t")
