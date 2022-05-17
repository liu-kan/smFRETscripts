setwd('E:/dbox/oc/data/smfret')
infile<-'kd.dat'
outfile<-"fit.csv"
outpdf<-"fit.pdf"
rSqu<-function(y,f){
  if(length(y)!=length(f)){
    print("length(y)!=length(f)")
    return (-1)
  }
  sumEline<-crossprod(f-y)
  sumMy<-crossprod(y-mean(y))
  return(1-sumEline/sumMy)
}
chiSqu<-function(y,f){
  if(length(y)!=length(f)){
    print("length(y)!=length(f)")
    return (-1)
  }
  return(sum((f-y)^2/f))
}

tab<-read.csv(infile, header = FALSE,sep='\t')
colnames(tab) <- c("x", "y")
x<-tab$x
#a+(ab-a)/100.*(x+50+k-sqrt((x+50+k).*(x+50+k)-200.*x))
res <- nls( y ~ a+(ab-a)/100*(x+50+k-sqrt((x+50+k)*(x+50+k)-200*x)), 
            start=c(a=0.1,ab=0.1,k=10) ,data = tab,
            control = nls.control(maxiter=15000)
            ,lower=c(0,0,0), upper=c(1,1,100))

v <- summary(res)$parameters[,"Estimate"]

#pdf(outpdf)
#devl<-dev.list()
#dev.set(devl["pdf"])
plot(y~x, data=tab)
plot(function(x) v[1]+(v[2]-v[1])/100*(x+50+v[3]-sqrt((x+50+v[3])*(x+50+v[3])-200*x)),
     col=2,add=T,xlim=range(tab$x) )
#dev.off()
tab$f<-v[1]+(v[2]-v[1])/100*(x+50+v[3]-sqrt((x+50+v[3])*(x+50+v[3])-200*x))
r2<-rSqu(tab$y,tab$f)
chis<-chiSqu(tab$y,tab$f)
write.csv(tab,file = outfile)
print(res)
print("R squared : ")
print(r2)
print("X^2 : ")
print(chis)
