n=3
r0=52;
nn=100;
f=@(x)mG(n,nn,fret,r0,x)
% population are:    0.6732    0.2726    0.0542
% mu of fret are:   44.9812   53.7431   71.5835
% sigma^2 are:   12.8824   45.8173  351.8759
p0=p{n};%[0.6732    0.2726    0.0542];
mu0=mu{n};%[44.9812   53.7431   71.5835];
v0=v{n};%[12.8824   45.8173  351.8759];
x0=[p0,v0,mu0];
mu00=[50,50];
umu=mu0+10;
lmu=mu0-10;
nonlcon = @unitdisk;
options = optimoptions('fmincon','Algorithm','interior-point','TolCon',1e-8,'Hessian',{'lbfgs',4},'TolFun',1e-9);
[x,fval] = fmincon(f,x0,[1,1,1,1,1,1],999999,[1,1,0,0,0,0],1,[p0-0.1,v0./5,lmu],[p0+0.1,v0.*5,umu],nonlcon,options);
%[x,fval] = fminunc(f,x0);
mu1=x(1:n);p1=x(n+1:2*n);v1=x(2*n+1:3*n);
figure
%rn=1;
nn=50;
[NN,center]=hist(fret,nn);
dcenter = diff(center(1:2));%center 格点，dcenter每格宽度
rNN=NN/sum(NN*dcenter);
%rNN=NN/trapz(center,NN);
meany=mean(rNN);
fx=zeros(n,nn);
sumfit=0;
fxx=zeros(1,nn);
for(idxr2=1:n)
    for(idxX=1:nn)    
        dfret=center(idxX);
        dxmu=r0.*(1./(dfret./100)-1).^(1/6)-mu1(idxr2);
        fx(idxr2,idxX)=p1(idxr2)/sqrt(v1(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/v1(idxr2));
    end
    sumfit=sumfit+sum(fx(idxr2,:)*dcenter);
end
fx=fx/sumfit;
fxx(:)=sum(fx,1);
ss_res=0;
ss_tot=0;
for(idxX=1:nn)
     ss_res=ss_res+(rNN(idxX)-fxx(idxX))*(rNN(idxX)-fxx(idxX));
     ss_tot=ss_tot+(rNN(idxX)-meany)*(rNN(idxX)-meany);
end
fprintf('R^2 is:');
  disp(max(0,1-ss_res/ss_tot));

bar(center,rNN,1.0,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
hold on
for(idxr2=1:n)    
    plot(center,fx(idxr2,:),'k','LineWidth',1,'LineStyle','--');
end
plot(center,fxx,'b','LineWidth',2);
hold off






