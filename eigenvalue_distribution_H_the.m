function [boundary_left, boundary_right, outlier] = eigenvalue_distribution_H_the(S, C, d,sigma ,pm, pc, pe, pam, pcm)
%This function generates the boundary for the eigenvalue distribution of the H matrix based on our theory

E_abs=sqrt(2/pi)*sigma;

if(pm+pc+pe+pam+pcm == 0)
    
    boundary_left=-d-sigma*sqrt(2*S*C);
    boundary_right=-d+sigma*sqrt(2*S*C);
    outlier=NaN;

end

if(pe == 1)
   
    %E_abs=sqrt(2/pi)*sigma;
    temp1=0;
    temp2=0.5*C*sigma^2-0.5*C*E_abs^2;
    
    boundary_left=-d-temp1-2*sqrt(S*temp2);
    boundary_right=-d-temp1+2*sqrt(S*temp2);
    outlier=NaN;
    
end

if(pm+pc == 1) && (pm == pc) && (pm == 0.5)
   
    %E_abs=sqrt(2/pi)*sigma;
    temp1=0;
    temp2=0.5*C*sigma^2+0.5*C*E_abs^2;
    
    boundary_left=-d-temp1-2*sqrt(S*temp2);
    boundary_right=-d-temp1+2*sqrt(S*temp2);
    outlier=NaN;
    
end

if(pc == 1)
   
    %E_abs=sqrt(2/pi)*sigma;
    temp1=-C*E_abs;
    temp2=0.5*C*sigma^2+0.5*C*E_abs^2-C^2*E_abs^2;
    
    boundary_left=-d-temp1-2*sqrt(S*temp2);
    boundary_right=-d-temp1+2*sqrt(S*temp2);
    outlier=-d+(S-1)*temp1;
    
end

if(pm == 1)
   
    %E_abs=sqrt(2/pi)*sigma;
    temp1=C*E_abs;
    temp2=0.5*C*sigma^2+0.5*C*E_abs^2-C^2*E_abs^2;
    
    boundary_left=-d-temp1-2*sqrt(S*temp2);
    boundary_right=-d-temp1+2*sqrt(S*temp2);
    outlier=-d+(S-1)*temp1;
    
end

if(pm+pc+pe+pam+pcm == 1) && (pm ~= 1) && (pc ~= 1) && (pe ~= 1) && (pam ~= 1) && (pcm ~= 1)
    
    %E_abs=sqrt(2/pi)*sigma;
    temp1=C*E_abs*(pm-pc+0.5*(pcm-pam));
    temp2=0.5*C*sigma^2*(1-0.5*(pcm+pam))+0.5*C*E_abs^2*(pm+pc-pe)-temp1^2;
    
    boundary_left=-d-temp1-2*sqrt(S*temp2);
    boundary_right=-d-temp1+2*sqrt(S*temp2);
    outlier=-d+(S-1)*temp1;
    
end

end