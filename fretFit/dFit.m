clear
r0=52;
load('fret.mat','fret');
if max(fret)<=1
    fret=fret*100;
end
x=r0.*(1./(fret./100)-1).^(1/6);
save('x.mat','x')
[n,p,mu,v]=fretFit();

figure(6)
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
        dxmu=r0.*(1./(dfret./100)-1).^(1/6)-mu{n}(idxr2);
        fx(idxr2,idxX)=p{n}(idxr2)/sqrt(v{n}(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/v{n}(idxr2));
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
