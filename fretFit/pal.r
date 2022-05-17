#library(OpenBlasThreads);

library(parallel);
#library(snowFT);
library(doParallel)
coreN<-detectCores(logical = T)-1
#coreN<-6
genHostName<-function(hostprefix,workingC,pad=0){
  num<-max(workingC)
  hostlist<-vector(length=length(workingC))
  numS<-nchar(toString(num))
  formatstr=paste('%0000000000000',pad,"d",sep="")
  ii<-1
  for (i in workingC){
    idx<-i
    if(pad>0)
      idx <- sprintf(formatstr, i)
    hostname <- paste( hostprefix,idx, sep = "")
    hostlist[ii]<-hostname
    ii<-ii+1
  }
  return(hostlist)
}

genWorkerList <- function(hostprefix,workingC,mc=0,tport = 10187,trshcmd = "ssh -p 22",tmaster="mu01",
                          tRs="",tSnowLib="")
{
  hL<-genHostName(hostprefix,workingC)
  wkM<-NULL
  for (i in seq(workingC)){
    if (nchar(tRs)>0&&nchar(tSnowLib)>0)
      wk<-list(host = hL[i],rscript=tRs,snowlib=tSnowLib)#,rshcmd =trshcmd)#,outfile = paste("./",hL[i],".log",sep = "")
    else
      wk<-list(host = hL[i])#,rshcmd =trshcmd)#,outfile = paste("./",hL[i],".log",sep = "")
    if(length(mc)==length(workingC)){
      wkM<-c(wkM,rep(list(wk),mc[i]))
#      print(paste("homogeneous",wkM))
    }
    else
      wkM<-c(wkM,rep(list(wk),mc[1]))
    #print(wk)
  }
  #wkL<-apply(wkM,1,"list")
  return(wkM)

}
genCluster <- function(hostprefix="10.10.0.",workingC=1:11,mc=0,logfile = "/tmp/Rr.log",masterHost="10.10.0.100",Rs="/home/liuk/local/bin/Rscript",SnowLib="/home/liuk/local/lib64/R/library"){
  if(mc==0)
    mc=coreN
  wkL<-genWorkerList(hostprefix,workingC,mc=mc,tRs=Rs,tSnowLib=SnowLib)
  options(showWarnCalls = T, showErrorCalls = T)
  #setDefaultClusterOptions(outfile=logfile)
  #setDefaultClusterOptions( homogeneous = FALSE)
  cls <- makeCluster( type="SOCK", wkL,master=masterHost)
  #clusterSetupSPRNG(cls)
  return(cls)
  #stopCluster(cls);
}

genLocalCluster <- function(mc=0,logfile = "/tmp/Rr.log"){
  wkL<-genWorkerList("localhos","t",mc=mc,tRs="/home/liuk/local/bin/Rscript",tSnowLib="/home/liuk/local/lib64/R/library")
  options(showWarnCalls = T, showErrorCalls = T)
  #setDefaultClusterOptions(outfile=logfile)
  cls <- makeCluster( type="SOCK", wkL)
  return(cls)
  #stopCluster(cls);
}

genHomeCluster<-function(){
  masterHost<-"10.0.0.11"
  alienOptions <-
    list(host = "10.0.0.11",
         rscript = "/usr/bin/Rscript",
         snowlib = "/home/liuk/R/x86_64-suse-linux-gnu-library/3.2")
  lnxOptions <-
    list(host = "10.0.0.13",
         rscript = "/usr/bin/Rscript",
         snowlib = "/home/liuk/R/x86_64-pc-linux-gnu-library/3.0")
  winOptions <-
    list(host="10.0.0.10",
         rscript="/usr/bin/Rscript",
         snowlib="/home/liuk/R/x86_64-redhat-linux-gnu-library/3.2")
  sonyOptions <-
    list(host = "10.0.0.12",
         rscript = "/usr/bin/Rscript",
         snowlib = "/home/liuk/R/x86_64-pc-linux-gnu-library/3.0")
  cl <- makeCluster(c(rep(list(alienOptions), 8), rep(list(lnxOptions), 8),rep(list(winOptions), 4),rep(list(sonyOptions), 4)),
                     type = "SOCK",master=masterHost) #rep(list(winOptions), 4)),
  return(cl)
}
