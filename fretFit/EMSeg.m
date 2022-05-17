function [AIC1,BIC1,mask,mu,v,p]=EMSeg(ima ,N,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ima=rgb2gray(ima);

ima=double(ima);

copy=ima;           % make a copy
ima=ima(:);         % vectorize ima
mi=min(ima);        % deal with negative 
%ima=ima-mi+1;       % and zero values
m=max(ima);
s=length(ima);

% create image histogram

%[h]=histogram(ima); %x为非0位置，
h=1/size(ima,1);
x=sort(ima');

% x=find(h)
% h=h(x);

x=x(:);h=h(:);

% initiate parameters

mu=(1:k)*m/(k+1);
v=ones(1,k)*m;   %v是max
p=ones(1,k)*1/k; %p是百分比 

% start process

sml = mean(diff(x))/1000;

while(1)
        % Expectation
        prb = distribution(mu,v,p,x);
        scal = sum(prb,2)+eps;
        loglik=sum(h.*log(scal));
                  
        %Maximizarion
        for j=1:k
                pp=h.*prb(:,j)./scal;
                p(j) = sum(pp);
                mu(j) = sum(x.*pp)/p(j);
                vr = (x-mu(j));
               v(j)=sum(vr.*vr.*pp)/p(j)+sml;
%                 v(j)=sum(vr.*vr.*pp)/p(j);
        end
        p = p + 1e-3;
        p = p/sum(p);

        % Exit condition
        prb = distribution(mu,v,p,x);
        scal = sum(prb,2)+eps;
        nloglik=sum(h.*log(scal)); 
        
        clf                       
        figure(1)
       
        [NN,center]=hist(ima,800);
           
         NN=NN/(k*N*(center(2)-center(1)));
         NN=NN';
         plot(center,NN);
          hold on
         plot(x,prb,'g--')
% %            save NN
        prbb = distribution(mu,v,p,center);
          plot(center,sum(prbb,2),'r')
       
         drawnow
                   
        if((nloglik-loglik)<0.00001) break; end;   
         
end

mmm=sum(prbb,2);

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

for i=1:s(1),
for j=1:s(2),
  for n=1:k
    c(n)=distribution(mu(n),v(n),p(n),copy(i,j)); 
  end
  a=find(c==max(c));  
  mask(i,j)=a(1);
end
end


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








