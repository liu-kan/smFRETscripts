function PY = Probability_of_Cluster_given_X(X,Means,Variances,PC,Label_of_Cluster)
PY = PC(Label_of_Cluster)*Mixing_Coefficient(X,Means(:,Label_of_Cluster), Variances(:,Label_of_Cluster));
PY = PY/Probability_of_X(X,Means,Variances,PC);
