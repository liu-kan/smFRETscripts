%���л���aic��ģ��ѡ����
clc
clear
rn=3; %ָ��Ҫ��ϳɶ��ٸ����������rn=-1 ���Զ��ж�
load x.mat %��������ݱ�����x.mat
k=4;%�����ܵ�����/2
fixmu=[]; %�̶�ĳ������ֵ,��[40,45],����С��k*2.
N = length(x); %��������ΪNxc
dim=1;%���ݵ�ά��
 
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
  fprintf('�ٷֱ� is %8.5f\n',mp{rn})
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





