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
library(bootstrap)
#fretdata  = read.table("data.txt",col.names='FRET')
fretdata  <- scan("data.txt")
fretdata  <-fretdata[1:200]

emP<-function(data){
  xdata<-matrix(data,ncol=1)
  #return(xdata)
  #print(xdata[1:3])
  ret <- init.EM(xdata, nclass = 3, method = "em.EM")
  #emobj <- simple.init(xdata, nclass = 3)
  #ret <- emcluster(xdata, emobj)#, assign.class = TRUE)
  print(ret$Mu)
  return(ret$pi)
}
results <- bootstrap(fretdata, 4,emP)

# view results
#results

std <- function(x) sd(x)/sqrt(length(x))
#results$t0
#se<-std(results$t)
#se
