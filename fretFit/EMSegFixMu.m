function [AIC1,BIC1,mask,mu,v,p]=EMSegFixMu(ima ,N,k,fixmu,padlen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fixmu must in form of [mu1,mu2,mu3,...]
%ima=rgb2gray(ima);
n8h=800;
fixu=0;
if(size(fixmu,2)>0)
    fixu=1;
end
if( size(fixmu,2)>k)
    fixu=0;
end
fixmu=sort(fixmu);
ima=double(ima);

copy=ima;           % make a copy
ima=ima(:);         % vectorize ima
mi=min(ima);        % deal with negative 
%ima=ima-mi+1;       % and zero values
m=max(ima);
s=length(ima);

% create image histogram

%[h]=histogram(ima); %x为非0位置，
h=1/size(ima,1); %每一格的宽度
x=sort(ima');

% x=find(h)
% h=h(x);

x=x(:);h=h(:);

% initiate parameters

mu=(1:k)*m/(k+1);
v=ones(1,k)*m;   %v是max
p=ones(1,k)*1/k; %p是百分比 此处是初值k等分
fmuStartIdx=1;
fixIdx=[];
mu0=mu;
if(fixu==1)
    for fmu=fixmu
        [mu,fmuStartIdx] = adjmu(mu,fmu,fmuStartIdx);
        fixIdx=[fixIdx,fmuStartIdx];        
    end
    mu0=mu;
end
%disp(mu)
% start process

sml = mean(diff(x))/1000;
iter=200;
while(1)
        % Expectation
        prb = distribution(mu,v,p,x);
        scal = sum(prb,2)+eps;  %每个不同fret值对应的总比例
        loglik=sum(h.*log(scal));
                  
        %Maximizarion
        for j=1:k
                pp=h.*prb(:,j)./scal;
                p(j) = sum(pp);
                if(fixu==1)
                    if( any(j==fixIdx)==0)
                        mu(j) = sum(x.*pp)/p(j);
                    else 
                        tr=(mod(randi([1,100],1),3)-1)*rand*padlen;
                        tc=2*(sum(x.*pp)/p(j)-mu0(j));
                        if(abs(tr)>abs(tc))
                            mu(j) = mu0(j)+tc;    
                        else
                            mu(j) = mu0(j)+tr;    
                        end
                    end
                else
                    mu(j) = sum(x.*pp)/p(j);
                end                
                vr = (x-mu(j));
              % v(j)=sum(vr.*vr.*pp)/p(j)+sml;
                 v(j)=sum(vr.*vr.*pp)/p(j);
        end
        %p = p + 1e-3;
        p = p/sum(p);

        % Exit condition
        prb = distribution(mu,v,p,x);
        scal = sum(prb,2)+eps;
        nloglik=sum(h.*log(scal)); 
        
        clf                       
        figure(1)
        %subplot(1,2,1)
        [NN,center]=hist(ima,n8h);
         NN=NN/(k*N*(center(2)-center(1)));
         NN=NN';         
         plot(center,NN);
         hold on
         plot(x,prb,'g--')
% %      save NN
          prbb = distribution(mu,v,p,center);
          plot(center,sum(prbb,2),'r')       
         drawnow           
         iter=iter-1;
        if((nloglik-loglik)<0.00001 || iter<0) break; end;   
         
end

mmm=sum(prbb,2);

     %[NN,center]=hist(ima,n8h);
       % y  x
       % y  f(x)
%mu v





AIC1=[];
BIC1=[];
ww=[];
ww=[ww k];

 AIC=(size(center,2)*log((NN-mmm)'*(NN-mmm)/size(center,2))+2*(3*k-1))/size(center,2);
 ww=[ww,AIC];
 AIC1=[AIC1,AIC];

 BIC=(size(center,2)*log((NN-mmm)'*(NN-mmm)/size(center,2))+log(size(center,2))*(3*k-1))/size(center,2);
 ww=[ww,BIC];
  BIC1=[BIC1,BIC];

 
% calculate mask
%mu=mu+mi-1;   % recover real range


s=size(copy);
mask=zeros(s);
% 
% for i=1:s(1),
% for j=1:s(2),
%   for n=1:k
%     c(n)=distribution(mu(n),v(n),p(n),copy(i,j)); 
%   end
%   a=find(c==max(c));  
%   mask(i,j)=a(1);
% end
% end


function y=distribution(m,v,g,x)
x=x(:);
m=m(:);
v=v(:);
g=g(:);
for i=1:size(m,1)
   d = x-m(i);
   amp = g(i)/sqrt(2*pi*v(i));
   y(:,i) = amp*exp(-0.5 * (d.*d)/v(i));
end


function [mur,fmuStartIdxR]=adjmu(mu,fmu,fmuStartIdx)
mur=mu;
lenMU=length(mu);
B=abs(mu(fmuStartIdx:lenMU)-fmu);
[x,index]=sort(B);
%A1=[A(index(1)) A(index(2))]
%idx=[index(1) index(2)]
mur(index(1)+fmuStartIdx-1)=fmu;
fmuStartIdxR=fmuStartIdx+index(1)-1;






