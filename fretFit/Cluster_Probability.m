% Function to compute the Cluster Probablity
function [PC,INDEX] = Cluster_Probability(Data,Mu)
[No_of_Features_within_Data,No_of_Data_Points] = size(Data);
[No_of_Features_within_Mu,No_of_Mu_Points] = size(Mu);
PC(1:No_of_Mu_Points) = 0;
INDEX(1:No_of_Data_Points) = 0;
Distance(1:No_of_Data_Points,1:No_of_Mu_Points) = 0.0;

for i=1:No_of_Data_Points
    for j = 1:No_of_Mu_Points
        Distance(i,j) = sqrt(dot(Data(:,i)-Mu(:,j),Data(:,i)-Mu(:,j)));
    end
end

for i=1:No_of_Data_Points
    [value,idx] = min(Distance(i,:));
    PC(idx) = PC(idx)+1;
    INDEX(i) = idx;
end

PC = PC/No_of_Data_Points; 