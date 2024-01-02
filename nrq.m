function [outp] = nrq(A,B,C,x0)
    xn=x0;
    n=length(x0);
    %eps=(10^-3)^n;
    eps = 10^-6;
    normd = eps+100;
    while normd > eps
        df=nrqjf(A,B,C,xn);
        xn=xn-df
        normd = norm(df);
    end
    outp=xn;
end
