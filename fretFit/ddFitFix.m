n=3;%拟合成 n 个高斯函数的和
r0=52;%Ai R_0距离
nn=40;%最终结果直方图bin的个数
nnl=100;%最终画线的点数
mu00=[24.9,48,63];%fret E 的中心值
dmu0=1;%fret E 波动范围mu00+/-dmu0
lp=[0.12065    0.54335    0.246];%比例的下边界
up=[0.1965    0.60335    0.306];%比例的上边界
uv=[140,90,60];%sgma最高值
lv=[5,5,5];%sgma最低值
load('fret.mat','fret');%从当前目录的fret.mat load fret变量——FRET E空间的直方图

nnn=800;
%global mu;
%mu=r0.*(1./(fmu)-1).^(1/6);
f=@(x)mGfix(n,nnn,fret,r0,x);
% population are:    0.6732    0.2726    0.0542
% mu of fret are:   44.9812   53.7431   71.5835
% sigma^2 are:   12.8824   45.8173  351.8759

%x0=[p0,v0,mu0];

umu=r0.*(1./((mu00-3)./100)-1).^(1/6);
lmu=r0.*(1./((mu00+3)./100)-1).^(1/6);
% umu=mu0+20;
% lmu=mu0-20;
[x,fval,exitflag,output,population,score] = GAmG(3*n,[1,1,1,0,0,0,0,0,0],1,[lp,lv,lmu],[up,uv,umu],100,1e-7,1e-4,n,nnn,fret,r0);
mu1=x(2*n+1:3*n);
p1=x(1:n);v1=x(n+1:2*n);
fmu1=1./(1+(mu1./r0).^6);

%rn=1;

[NN,center]=hist(fret,nn);
[NNl,centerl]=hist(fret,nnl);
dcenter = diff(center(1:2));%center 格点，dcenter每格宽度
dcenterl = diff(centerl(1:2));%center 格点，dcenter每格宽度
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

fxl=zeros(n,nnl);
sumfitl=0;
fxxl=zeros(1,nnl);
for(idxr2=1:n)
    for(idxX=1:nnl)    
        dfret=centerl(idxX);
        dxmu=r0.*(1./(dfret./100)-1).^(1/6)-mu1(idxr2);
        fxl(idxr2,idxX)=p1(idxr2)/sqrt(v1(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/v1(idxr2));
    end
    sumfitl=sumfitl+sum(fxl(idxr2,:)*dcenterl);
end
fxl=fxl/sumfitl;
fxxl(:)=sum(fxl,1);
figure
bar(center,rNN,1.0,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
hold on
for(idxr2=1:n)    
    plot(centerl,fxl(idxr2,:),'k','LineWidth',1,'LineStyle','--');
end
plot(centerl,fxxl,'b','LineWidth',2);
hold off

fprintf('sigma are:');
  disp(v1);
fprintf('fret E centers are:');
  disp(fmu1);
fprintf('P are:');
  disp(p1);
fprintf('Dis centers are:');
  disp(mu1);
disp('rNN是实验直方图,直方图x是center; Fit data X in centerl & sum Gauss in fxxl & Gauss in fxl(1,:), fxl(2,:), fxl(3,:) ...');



