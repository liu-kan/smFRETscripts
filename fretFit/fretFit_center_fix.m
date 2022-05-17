%具有基于aic的模型选择功能
clc
clear
rn=3; %指定要拟合成多少个函数。如果rn=-1 则自动判断
load x.mat %被拟合数据保存在x.mat
k=4;%最大可能的类数/2
fixmu=[]; %固定某几个均值,如[40,45],个数小于k*2.
N = length(x); %总数据数为Nxc
dim=1;%数据的维数
 
 result1=[];
 result2=[];
AI=[];
BI=[];
N1=[];

ima=x;
jj=1;

mmu={};
mv={};
mp={};

while jj<=2*k
%while jj<=1
 [AIC1,BIC1,mask,mu,v,p]=EMSegFixMu(ima ,N,jj,fixmu);
 mmu{jj}=mu;
 mv{jj}=v;
 mp{jj}=p;
%[AIC1,BIC1,NS1,www,mask,mu,v,p]=EMSeg(ima ,k);

 AI=[AI,AIC1];
 BI=[BI,BIC1];

% save result
  jj=jj+1;
end
   
 
  AI
  BI
  rr=find(AI==min(AI))
  bb=find(BI==min(BI))
if (rn<0)
    rn=rr
end
  fprintf('百分比 is %8.5f\n',mp{rn})
  fprintf('mu is %8.5f\n',mmu{rn})
  fprintf('sigma^2 is %8.5f\n',mv{rn})
  

 figure(2);
 h1=plot(AI,'r');
 hold on
  h2=plot(BI,'b'); 
   legend('AIC','BIC')


% % imamin=min(ima);
% % imamax=max(ima);
% % imalength=length(ima);
% % nn=(imamax-imamin)+1;

figure(3)
 nn=300;
[NN,center]=hist(ima,40);

%center=conv(center,[1,2,3,2,1]);
plot(center,NN);

% % 
% % 
% % %randint(1,1,[2,3])





