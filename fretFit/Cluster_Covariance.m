%Co-variance Computation for a Cluster
function [COVAR] = Cluster_Covariance(Data)
[r,c] = size(Data);
if(c>1)
for i=1:r
    COVAR(i) = cov(Data(i,:));
end;
else
    COVAR(1:r) = 1;
end;
