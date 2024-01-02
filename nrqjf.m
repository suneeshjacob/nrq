function [outp] = nrqjf(A,B,C,x0)
    n = length(x0);
    f=nrqf(A,B,C,x0);
    J=[];
    for i = 1:n
        
        A2=A(A(:,3)==i,:);
        A3=A2(diff(A2(:,1:2),1,2)==0,:);
        A4=A2(diff(A2(:,1:2),1,2)~=0,:);
        
        sA3=size(A3,1);
        J(size(J,1)+1:size(J,1)+sA3,:)=[i*ones(sA3,1),A3(:,1),x0(A3(:,1)).*(A3(:,4)*2)];
        
        i7=unique(A4(:,1:2));
        if size(i7,1)~=1
            i7=i7';
        end
        for j = i7
            i11 = sum(A4(:,1:2)==j,2)==1;
            i10 = A4(i11,1:2);
            i10(i10==j)=[];
            i10=i10';
            i12 = sum(J(:,1:2)==[i,j],2)==2;
            if any(i12)
                J(i12,3) = J(i12,3) + x0(i10)'*A4(i11,4);
            else
                J(size(J,1)+1,:) = [i, j, x0(i10)'*A4(i11,4)];
            end
            
        end
    end
    J_final = sparse(J(:,1),J(:,2),J(:,3))+sparse(B(:,1),B(:,2),B(:,3));
    outp = J_final\sparse(f);
    outp = full(outp);
end
