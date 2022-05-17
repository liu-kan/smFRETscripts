function [fitresult, gof] = KdNlinfit(At, Delta)
%该函数用于计算多元非线性拟合
beta0=[0.9,0.1,25];
lb=[0,0,0];
ub=[1,1,100];
%x=[X;Y];
x=At;
y=Delta;
options = statset('MaxIter',10000);
myfunc=inline('c(1)+(c(2)-c(1))/100.*(x+50+c(3)-sqrt((x+50+c(3)).*(x+50+c(3))-200.*x))','c','x','y')
p=lsqnonlin(myfunc,beta0,lb,ub,options,x,y)

%c=lsqnonlin(@myfun,x,y,beta0,lb,ub);
%display(['delta_a=',num2str(c(1)),' delta_ab=',num2str(c(2)),' Kd=',num2str(c(3))])
%实际计算的时候将下面的函数单独写成一个M文件
%function y=myfun(c,x)
%y=c(1)+(c(2)-c(1))/100.*(x+50+c(3)-sqrt((x+50+c(3)).*(x+50+c(3))-200.*x));


