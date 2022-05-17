%���л���aic��ģ��ѡ����

%   disp(mp{rn});
%   fprintf('mu of fret are:');
%   disp(mmu{rn});
%   fprintf('sigma^2 are:');
%   disp(mv{rn});
%   
function [rn,mp,mmu,mv]=fretFit()
rn = 3; %ָ��Ҫ��ϳɶ��ٸ����������rn=-1 ���Զ��ж�
load('x.mat','x') %��������ݱ�����x.mat
%load('fret.mat','fret');
%x=fret;
k=2;%�����ܵ�����/2
fixmu=[];%[52,33]; %�̶�ĳ������ֵ,��[40,45],����С��k*2.
padlen=3; %�̶���ֵ �Ŀɵ�����Χ >=0,�������ʱ����
N = length(x); %��������ΪNxc
dim=1;%���ݵ�ά��
 
result1=[];
result2=[];
AI=[];
BI=[];
N1=[];
%r2=[];

ima=x;
jj=1;

mmu={};
mv={};
mp={};

while jj<=2*k
%while jj<=1
 [AIC1,BIC1,mask,mu,v,p]=EMSegFixMu(ima ,N,jj,fixmu,padlen);
 mmu{jj}=mu;
 mv{jj}=v;
 mp{jj}=p;
%[AIC1,BIC1,NS1,www,mask,mu,v,p]=EMSeg(ima ,k);

 AI=[AI,AIC1];
 BI=[BI,BIC1];
 %r2=[r2,r2r];
% save result
  jj=jj+1;
end
   
 
  AI
  BI
  rr=find(AI==min(AI))
  bb=find(BI==min(BI))
  rn
if (rn<0)
    rn=rr;
end
rn
  fprintf('population are:');
  disp(mp{rn});
  fprintf('mu of fret are:');
  disp(mmu{rn});
  fprintf('sigma^2 are:');
  disp(mv{rn});
  

 figure(2);
 h1=plot(AI,'r');
 hold on
  h2=plot(BI,'b');  
   legend('AIC','BIC');
   hold off;

% % imamin=min(ima);
% % imamax=max(ima);
% % imalength=length(ima);
% % nn=(imamax-imamin)+1;

figure(3)
%rn=1;
nn=50;
[NN,center]=hist(ima,nn);

%center=conv(center,[1,2,3,2,1]);
%plot(center,NN);
%ss_res=0;
%ss_tot=0;
dcenter = diff(center(1:2));
rNN=NN/sum(NN*dcenter);
%rNN=NN/trapz(center,NN);
meany=mean(rNN);
fx=zeros(rn,nn);
sumfit=0;
fxx=zeros(1,nn);
for(idxr2=1:rn)
    for(idxX=1:nn)    
        dxmu=center(idxX)-mmu{rn}(idxr2);
        fx(idxr2,idxX)=mp{rn}(idxr2)/sqrt(mv{rn}(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/mv{rn}(idxr2));
    end
    sumfit=sumfit+sum(fx(idxr2,:)*dcenter);
end
fx=fx/sumfit;
fxx(:)=sum(fx,1);


% figure(4)
% fx=zeros(1,100);
% for(idxr2=1:rn)
%     fx=fx+gaussmf(center,[mv{rn}(idxr2),mmu{rn}(idxr2)])/sqrt(mv{rn}(idxr2)*2*pi);
% end
bar(center,rNN,1.0,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5);
hold on
for(idxr2=1:rn)    
    plot(center,fx(idxr2,:),'k','LineWidth',1,'LineStyle','--');
end
plot(center,fxx,'b','LineWidth',2);
hold off
% % 
% % 
% % %randint(1,1,[2,3])
figure(4)
h3=plot(center,fxx-rNN,'k'); 
legend('fx-y','Location','southeast')


%center=conv(center,[1,2,3,2,1]);

figure(5)
r3=1:2*k;
r4=r3;
for rnn=1:2*k
    fx=zeros(rnn,nn);
    sumfit=0;
    fxx=zeros(1,nn);
    for(idxr2=1:rnn)
        for(idxX=1:nn)    
            dxmu=center(idxX)-mmu{rnn}(idxr2);
            fx(idxr2,idxX)=mp{rnn}(idxr2)/sqrt(mv{rnn}(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/mv{rnn}(idxr2));
        end
    %     ss_res=ss_res+(rNN(idxX)-fx(idxX))*(rNN(idxX)-fx(idxX));
    %     ss_tot=ss_tot+(rNN(idxX)-meany)*(rNN(idxX)-meany);
        %fx(idxr2,:)=fx(idxr2,:)/(sum(fx(idxr2,:)*dcenter)*mp{rn}(idxr2));
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
    r4(rnn)=max(0,1-ss_res/ss_tot);
    %r3(rn)=rsquare(rNN,fxx);
end
plot(r4,'k'); 
legend('R^2','Location','southeast')