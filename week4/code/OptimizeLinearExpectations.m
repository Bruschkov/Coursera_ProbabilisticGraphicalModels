% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeLinearExpectations( I )
  % Inputs: An influence diagram I with a single decision node and one or more utility nodes.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  % You may assume that there is a unique optimal decision.
  %
  % This is similar to OptimizeMEU except that we will have to account for
  % multiple utility factors.  We will do this by calculating the expected
  % utility factors and combining them, then optimizing with respect to that
  % combined expected utility factor.  
  MEU = [];
  OptimalDecisionRule = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  % A decision rule for D assigns, for each joint assignment to D's parents, 
  % probability 1 to the best option from the EUF for that joint assignment 
  % to D's parents, and 0 otherwise.  Note that when D has no parents, it is
  % a degenerate case we can handle separately for convenience.
  %
  
  U = I.UtilityFactors;
  mus = [];
  for i=1:length(U)
    I.UtilityFactors = U(i);
    mus = [mus CalculateExpectedUtilityFactor(I)];
  end
  
  mu = mus(1);
  if (length(mus) > 1)
    mu = FactorSum(mu, mus(i));
  end

  
  D = I.DecisionFactors(1);
  D.val = zeros(1, prod(D.card));

  % case: D has no parents
  if (length(D.var) == 1)
    [_, idx]=max(mu.val);
    D.val(idx) = 1;
  % case: D has n >= 1 parents
  else
    k = prod(D.card(2:end));
    for i=0:D.card(1)-1
      m = mu.val(1+i*k:k+i*k);
      [_, idx]=max(m);
      D.val(idx+i*k) = 1;
    end
  end
  OptimalDecisionRule = D;
  MEU = sum(FactorProduct(mu,D).val);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  



end
