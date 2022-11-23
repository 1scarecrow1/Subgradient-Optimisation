function [ LB_best, UB_best, x_best, LB_list, UB_list ] = SubgradientOpt( c, A, lambda_init, rho_init, k )
   lambda = lambda_init; %initialising lambda 
   LB_list = zeros(k,1); %list to store UB and LB found in each iteration
   UB_list = zeros(k,1);
   x_matrix = zeros(length(c),k); %matrix to store x obtained at each iteration
   UB_best = Inf;
      
   for j = 1:k  
       rho = rho_init/j;
      [LB, x_infeas] = Lagrangian( c, A, lambda);   %get x_infeas and use it to get obj value (LB)
      [UB, x_feas] = InfeasToFeas( c, A, x_infeas); % get x feas and use it to get obj value (UB) 
      LB_list(j,1) = LB; %update both lists
      UB_list(j,1) = UB;
      if UB <= UB_best %retain best upper bound at each iteration
          UB_best = UB;
      
      end
      x_matrix(:,j) = x_feas; %add x_feas at each iteration to the matrix         
      lambda = UpdateLambda( A, lambda, LB, UB_best, x_infeas, rho );
      
   end
        [M,I]= min(UB_list);
        UB_best = min(UB_list);
        x_best = x_matrix(:,I); %to find x corresponding to best upper bound
        LB_best = max(LB_list);
       
    
end
  