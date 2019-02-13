% Copyright (C) Daphne Koller, Stanford University, 2012

function EUF = CalculateExpectedUtilityFactor( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: A factor over the scope of the decision rule D from I that
  % gives the conditional utility given each assignment for D.var
  %
  % Note - We assume I has a single decision node and utility node.
  EUF = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  %
  % As per the generalized Expected Utility-Formula From the Lecture Slides
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);
  D = I.DecisionFactors(1);
  vars = [];
  G = [I.RandomFactors, U];
  for i=1:length(G)
    vars = [vars G(i).var];
  end
  W = setdiff(vars, D.var);
  M = VariableElimination([I.RandomFactors U], W);
  
  mu = M(1);
  if (length(M) > 1)
    for i=2:length(M)
      mu = FactorProduct(mu, M(i));
    end
  end
  EUF = mu;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


  
end  
