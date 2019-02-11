% Copyright (C) Daphne Koller, Stanford University, 2012

function EU = SimpleCalcExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.

  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);
  EU = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %

  % As per the generalized Expected Utility-Formula From the Lecture Slides
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

  EU = sum(FactorProduct(D, mu).val)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
  
  
end
