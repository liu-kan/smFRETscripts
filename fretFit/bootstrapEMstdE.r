swdir <- tryCatch(
       {
         library(rstudioapi)
         script.dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
         #script.dir
         setwd(script.dir)
       },
       error=function(cond) {
           message(cond)
       }
)
swdir

library(EMCluster, quietly = TRUE)
library(boot, quietly = TRUE)
#fretdata  = read.table("data.txt",col.names='FRET')
fretdata  <- scan("data.txt")
emP<-function(data,idx){
  xdata<-matrix(data[idx],ncol=1)
  #return(xdata)
  #print(xdata[1:3])
  ret <- init.EM(xdata, nclass = 3, method = "em.EM")
  #emobj <- simple.init(xdata, nclass = 3)
  #ret <- emcluster(xdata, emobj)#, assign.class = TRUE)
  #print(ret$Mu)
  return(ret$pi)
}
source('pal.r')
RNGkind("L'Ecuyer-CMRG")
cl<-genCluster(workingC=c(4:6,9:10),mc=0,hostprefix="192.168.1.",masterHost="192.168.1.100",Rs="/opt/local/bin/Rscript",SnowLib="/home/liuk/R/x86_64-pc-linux-gnu-library/3.3")
registerDoParallel(cl)
#clusterExport(cl, varlist = c("A","R2", "calc4r2","nbits","hnbits","vaFileNum","spreData"))
clusterCall(cl, library, package = "EMCluster", character.only = TRUE)
#clusterCall(cl, library, package = "GA", character.only = TRUE)


#set.seed(1234)
results <- boot(data=fretdata, statistic=emP,cl=cl,
                R=1000,parallel="snow",simple=T)
# view results
#results

std <- function(x) sd(x)/sqrt(length(x))
stderr <- function(x) sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))
print(paste("p:",sort(results$t0)))
pa<-results$t
rpa<-matrix(nrow=nrow(pa),ncol=ncol(pa))
for (i in 1:nrow(pa)){
  rpa[i,]=sort(pa[i,])
}
for (i in 1:ncol(pa)){
  se<-stderr(rpa[,i])
  print(paste('stderr:',se))
}
