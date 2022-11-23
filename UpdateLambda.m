function lambda_next = UpdateLambda( A, lambda, LB, UB, x_lagrange, rho )

if norm(ones(size(A,1),1)-A*x_lagrange) ~= 0 %update lambda according to stopping condition
    miu = rho*((UB - LB)/((norm(ones(size(A,1),1)-A*x_lagrange))^2));
    lambda_next = lambda + miu*(ones(size(A,1),1)-A*x_lagrange);
     
    for i = 1:length(lambda) %set negative components of new lambda to 0
        if lambda_next(i) < 0 
        lambda_next(i) = 0;
        end
    end
    
elseif norm(ones(size(A,1),1)-A*x_lagrange) == 0 %in case of optimal solution, don't need rho
    lambda_next = lambda;
    
end

   
end
