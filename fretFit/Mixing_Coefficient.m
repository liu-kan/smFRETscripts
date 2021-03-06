function MC = Mixing_Coefficient(X,MU,SIGMA)
M = normpdf(X,MU,SIGMA);
[r,c] = size(M);
MC = 0.0;
for i=1:c
    MC = MC + M(i);
end
MC = MC/c;
