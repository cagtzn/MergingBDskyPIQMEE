library(coda)
args <- commandArgs(trailingOnly = TRUE)
fname <- args[1]
#Read data
#
data <- read.table(fname, header= T)
start<-floor(0.1*length(data$Sample)) # burn-in
end<-length(data$Sample)
data<-data[-(1:start),]
#HPD
#
treeH_HPD<-HPDinterval((as.mcmc(data$TreeHeight)))
rho_HPD<-HPDinterval((as.mcmc(data$rhoContemp)))
Re_HPD<-HPDinterval((as.mcmc(data$reproductiveNumberContemp)))
row.names(Re_HPD)="Re"; row.names(rho_HPD)="Rho";row.names(treeH_HPD)="Tree Height"
#Write
writeThis<-rbind(treeH_HPD,rho_HPD, Re_HPD)
write.table(writeThis, file=paste0(fname,"_HPD.txt"), sep="\t")
