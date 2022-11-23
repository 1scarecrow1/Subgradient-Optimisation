function [ obj_lagrange, x_lagrange ] = Lagrangian( c, A, lambda )
%%
% $x^2+e^{\pi i}$
x_lagrange=zeros(length(c),1); 
%initialising vector x with zeros
for i = 1:size(A', 1)
    if lambda'*A(:,i)> c(i,1)
        x_lagrange(i,1) = 1;
%if dual constraint is satisfied, we choose x(i,1)
    elseif lambda'*A(:,i) <= c(i,1)
        x_lagrange(i,1) = 0;
      
    end
end
obj_lagrange = c'*x_lagrange-lambda'*A*x_lagrange + sum(lambda);

end

