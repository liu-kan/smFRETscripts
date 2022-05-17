mp=[  0.1880    0.3762    0.4358];
mu =[ 24.3450   51.3492   66.5970];
mv=[    124.9975  119.6753   86.1953];
sc=4044*100/40
b=0:99;
f=sc.*(mp(1)*exp(-(b-mu(1)).^2./(2*mv(1)) )./sqrt(2*pi*mv(1))+mp(2)*exp(-(b-mu(2)).^2./(2*mv(2)))./sqrt(2*pi*mv(2))+mp(3)*exp(-(b-mu(3)).^2./(2*mv(3)))./sqrt(2*pi*mv(3)));
f1=sc.*mp(1)*exp(-(b-mu(1)).^2./(2*mv(1)) )./sqrt(2*pi*mv(1));
f2=sc.*mp(2)*exp(-(b-mu(2)).^2./(2*mv(2)))./sqrt(2*pi*mv(2));
f3=sc.*mp(3)*exp(-(b-mu(3)).^2./(2*mv(3)))./sqrt(2*pi*mv(3));
figure(3)
hold on
plot(b,f,'k-',b,f1,'r-',b,f2,'g-',b,f3,'y-');