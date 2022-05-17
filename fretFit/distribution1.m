function y=distribution1(m,v,g,x)
x=x(:);
m=m(:);
v=v(:);
g=g(:);
for i=1:size(m,1)
   d = x-m(i);
   amp = g(i)/sqrt(2*pi*v(i));
   y(:,i) = amp*exp(-0.5 * (d.*d)/v(i));
end

% x=x(:);
% m=m(:);
% v=v(:);
% g=g(:);
% for i=1:size(m,1)
%    d = x-m(i);
%    amp = g(i)/sqrt(2*pi*v(i));
%    y(:,i) = amp*exp(-0.5 * (d.*d)/v(i));
% end