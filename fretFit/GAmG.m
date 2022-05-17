function [x,fval,exitflag,output,population,score] = GAmG(nvars,Aeq,beq,lb,ub,PopulationSize_Data,TolFun_Data,TolCon_Data,n,nn,fret,r0)

options = gaoptimset;
options = gaoptimset(options,'PopulationSize', PopulationSize_Data);
options = gaoptimset(options,'MigrationDirection', 'both');
options = gaoptimset(options,'TolFun', TolFun_Data);
options = gaoptimset(options,'TolCon', TolCon_Data);
options = gaoptimset(options,'CreationFcn', @gacreationnonlinearfeasible);
options = gaoptimset(options,'CrossoverFcn', {  @crossoverheuristic [] });
options = gaoptimset(options,'MutationFcn', @mutationadaptfeasible);
options = gaoptimset(options,'HybridFcn', {  @fmincon [] }); %fmincon patternsearch
options = gaoptimset(options,'Display', 'final');
options = gaoptimset(options,'PlotFcns', {  @gaplotbestf @gaplotbestindiv @gaplotdistance @gaplotstopping });
[x,fval,exitflag,output,population,score] = ...
ga(@(x)mGfix(n,nn,fret,r0,x),nvars,[],[],Aeq,beq,lb,ub,[],[],options);
