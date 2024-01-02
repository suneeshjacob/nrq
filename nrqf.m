function [outp] = nrqf(A,B,C,x0)
    n = length(x0);
    outp = zeros(size(C));
    for i = 1:n
        
        A2=A(A(:,3)==i,:);
        sumtemp1 = prod(x0(A2(:,1:2)),2)'*A2(:,4);
        outp(i,:) = sumtemp1;

    end
    %outp=full(sparse(outp)+sparse(B(:,1),B(:,2),B(:,3))*sparse(x0)+sparse(C(:,1),C(:,2),C(:,3)));
    outp=full(sparse(outp)+sparse(B(:,1),B(:,2),B(:,3))*sparse(x0)+sparse(C));
    
end
