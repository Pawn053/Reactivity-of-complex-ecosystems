function dxdt = gLVFun(t,x,r,A)
%This function generates generalized Lotka-Volterra dynamics

%t - Simulation time
%x - Species abundance vector
%r - Intrinsic growth rate vector
%A - Interaction matrix

S=max(size(A));

for i=1:S
    
    if(x(i)<=2*10^-2)
        x(i)=0;
    end
    
end

for i=1:S
    flag1=0;
    for j=1:S
        flag1=flag1+A(i,j)*x(j);
    end
    flag1=flag1+r(i);
    dxdt(i,1)=x(i)*flag1;
    %dxdt(i,1)=flag1;
end

end

