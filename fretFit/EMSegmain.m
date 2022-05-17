%第一次编写好的程序,具有基于NS的模型选择功能


clc
clear

k=4;%类数
N = 2500 %总数据数为Nxc
dim=1;%数据的维数
 
 result1=[];
 result2=[];
AI=[];
BI=[];
N1=[];
mmuu=[];
vv=[];

 one=ones(1,5);
 oo=1;
 while oo<=1
i=1;
data=[];
ii=2;
random1=ones(1,k);
random1(:)=randperm(k);
random1=sort(random1);
while i<=k
    jm=5;
    while random1(i)>4 
        random1(i)=random1(i)/jm;
        jm=jm+1;
    end
  
%Data=normrnd(15*i, random1(i),dim,N);
mmuu1=randint(1,1,[1 200])
vv1=random1(i)
 Data=normrnd(mmuu1,vv1,dim,N);
 mmuu=[mmuu mmuu1];
 vv=[vv vv1];
data=[data Data];
i=i+1;
end
data=data';

ima=data;
jj=1;

while jj<=2*k
%while jj<=1
 [AIC1,BIC1,mask,mu,v,p]=EMSeg(ima ,N,jj);
%[AIC1,BIC1,NS1,www,mask,mu,v,p]=EMSeg(ima ,k);
if jj==k
    mmuu
    vv
   p
   mu
  v
end


 AI=[AI,AIC1];
 BI=[BI,BIC1];

% save result
  jj=jj+1;
end
    oo=oo+1;
  end
 
  rr=find(min(AI))
  bb=find(min(BI))
  AI
  BI

 figure(2);
 h1=plot(AI,'r');
 hold on
  h2=plot(BI,'b'); 
   legend('AIC','BIC')
   


 
 


% 


% % imamin=min(ima);
% % imamax=max(ima);
% % imalength=length(ima);
% % nn=(imamax-imamin)+1;

figure(3)
 nn=300;
[NN,center]=hist(ima,300);

%center=conv(center,[1,2,3,2,1]);
plot(center,NN);

% % 
% % 
% % %randint(1,1,[2,3])





