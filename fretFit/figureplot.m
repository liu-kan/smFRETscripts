mp=[ 0.3788    0.6212];
mu =[  39.8168   72.0150];
mv=[    345.0213  105.6760];
sc=6088*100/40
b=0:99
f=sc.*(mp(1)*exp(-(b-mu(1)).^2./(2*mv(1)) )./sqrt(2*pi*mv(1))+mp(2)*exp(-(b-mu(2)).^2./(2*mv(2)))./sqrt(2*pi*mv(2)));
f1=sc.*mp(1)*exp(-(b-mu(1)).^2./(2*mv(1)) )./sqrt(2*pi*mv(1));
f2=sc.*mp(2)*exp(-(b-mu(2)).^2./(2*mv(2)))./sqrt(2*pi*mv(2));
figure(3)
hold on
plot(b,f,'k-',b,f1,'r-',b,f2,'g-');