% Clustering by Gaussian Mixture Model

clc
clear
% GMM Example

No_of_Clusters = 3;
No_of_Iterations = 1115;

x1 = 10 + sqrt(3) * randn(1,100);
x2 = 12 + sqrt(5) * randn(1,100);
x3 = 14 + sqrt(2) * randn(1,100);
Input = [x1 x2 x3];
save Input
% data=normrnd(8,2,1,100);
% data1=normrnd(15,1.5,1,100);
% data2=normrnd(20,1.1,1,100);
% Input = [data data1 data2];

% [INDEX,Mu, Variances] = GMM(Input, No_of_Clusters,No_of_Iterations);


%function [INDEX, Mu, Variances] = GMM(Input, No_of_Clusters,Limit)

% Initialize_the_Cluster_Centroid
[IDX, Initial_Centroids] = kmeans(Input',No_of_Clusters);

Mu = Initial_Centroids'
Limit = 110;

for Iterations = 1:Limit
[No_of_Features_within_Data,No_of_Data_Points] = size(Input);
Probability_of_Cluster_given_Point(1:No_of_Clusters,1:No_of_Data_Points) = 0.0;
[PC,INDEX] = Cluster_Probability(Input,Mu);

%Initialize Cluster Covariances
COVAR(1:No_of_Features_within_Data,1:No_of_Clusters) = 0.0;
for i=1:No_of_Clusters 
    
   COVAR(:,i) = Cluster_Covariance(Input(:,IDX==i));
end
  
%Initialize the probability matrix P(Cluster/Point)
Variances = COVAR;
for i=1:No_of_Clusters
for j=1:No_of_Data_Points
Probability_of_Cluster_given_Point(i,j) = Probability_of_Cluster_given_X(Input(:,j),Mu,Variances,PC,i);
end;
end;


% New Means
Mu1(1:No_of_Clusters,1:No_of_Features_within_Data) = 0.0;
for i=1:No_of_Clusters
Mu1(i,:) = Compute_Mean_for_Cluster(Input,Mu,Variances,PC,i);
end;
%disp(Iterations);
%disp(Mu1);
Mu = Mu1';
end;

Mu
Variances


















