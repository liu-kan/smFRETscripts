function y=mG(n,nn,fret,r0,x)
    %x0=[mu0,p0,v0];
        p=x(1:n);
    v=x(n+1:2*n);
    mu=x(2*n+1:3*n);
    [NN,center]=hist(fret,nn);
    dcenter = diff(center(1:2));%center 格点，dcenter每格宽度
    rNN=NN/sum(NN*dcenter);
    meany=mean(rNN);
    fx=zeros(n,nn);
    sumfit=0;
    fxx=zeros(1,nn);
    for(idxr2=1:n)
        for(idxX=1:nn)    
            dfret=center(idxX);
            dxmu=r0.*(1./(dfret./100)-1).^(1/6)-mu(idxr2);
            fx(idxr2,idxX)=p(idxr2)/sqrt(v(idxr2)*2*pi)*exp(-0.5 * (dxmu*dxmu)/v(idxr2));
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
    y=ss_res;
end