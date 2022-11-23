function [ obj_feas, x_feas ] = InfeasToFeas( c, A, x_infeas )

C = zeros(size(A,1),1); %vector of customers satisfied
smallestIndex = 0;
x_feas=x_infeas;

for i = 1:size(A, 1)
    if (A(i, :))*x_infeas < 1
        C(i, :) = 1; %add customers to route if constraint is satisfied
    end
end
while sum(C) > 0
    bestSize=0; 
    for j = 1:size(A,2)
        if((C'*A(:,j))/c(j,1)>bestSize) %select route which maximises ratio between additional number                                                
            bestSize=(C'*A(:,j))/c(j,1); %of customers covered by this route and the cost of opening this route
            smallestIndex=j; %choose smallest index to break ties
        end
    end
    x_feas(smallestIndex,1) = 1;
    C = zeros(size(A,1),1); %set to 0 again to find ratio with new customers
    for i = 1:size(A, 1)
        if (A(i, :))*x_feas < 1
            C(i, :) = 1;
        end
    end
end
obj_feas=c'*x_feas; %calculate objective value with primal feasible solution
end