n=9;
xf = sym('x',[n,1]);
const = 10;


ff = xf;
A = [];
B = [];
C = [];

Am = nan(n,n,n);
Bm = nan(n,n);
Cm = nan(n,1);

for p = 1:n
    Ar = randi([-const,const],n,n);
    br = randi([-const,const],1,n);
    cr = randi([-const,const],1,1);

    Am(:,:,p) = Ar;
    Bm(:,p) = br;
    Cm(p,1) = cr;
    for i = 1:n
        for j = 1:n
            if i<j
                A(end+1,:) = [i,j,p,Ar(i,j)+Ar(j,i)];
            elseif i==j
                A(end+1,:) = [i,j,p,Ar(i,i)];    
            else
                
            end
        end
        B(end+1,:) = [p,i,br(i)];
    end
    C(end+1,1) = cr;
    ff(p) = transpose(xf)*Ar*xf+br*xf+cr;
end

ff_mf = mf(ff);
x0 = rand(n,1);
tic
xv = nrq(A,B,C,x0);
a1 = toc;
tic
xv2 = nr_mf(ff_mf,x0);
a2 = toc;
double(subs(ff,xf,xv))