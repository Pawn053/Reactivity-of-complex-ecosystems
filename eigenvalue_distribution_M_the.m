function [boundary_left, boundary_right, outlier] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm)
%This function generates the boundary for the eigenvalue distribution of
%the community matrix based on Alleinsa and Foster's work (Allesina, Nature, 2012 & Foster, Science, 2015)

E_abs=sqrt(2/pi)*sigma;

if(pm+pc+pe+pam+pcm == 0)
    
    boundary_left=-d-sigma*sqrt(S*C);
    boundary_right=-d+sigma*sqrt(S*C);
    
    outlier=NaN;
    
end

if(pe == 1)
    
    temp=E_abs/sigma;
    temp=temp^2;
    
    boundary_left=-d-sigma*sqrt(S*C)*(1-temp);
    boundary_right=-d+sigma*sqrt(S*C)*(1-temp);
    
    outlier=NaN;
    
end

if(pm+pc == 1) && (pm == pc)
    
    temp=E_abs/sigma;
    temp=temp^2;
    
    boundary_left=-d-sigma*sqrt(S*C)*(1+temp);
    boundary_right=-d+sigma*sqrt(S*C)*(1+temp);
    
    outlier=NaN;
    
end  

if(pc == 1)
    
    temp1=sigma^2+(1-2*C)*E_abs^2;
    temp1=temp1/(sigma^2-C*E_abs^2);
    
    temp2=sigma^2-C*E_abs^2;
    temp2=sqrt(S*C*temp2);
    
    boundary_left=-d+C*E_abs-temp1*temp2;
    boundary_right=-d+C*E_abs+temp1*temp2;
    
    outlier=-d-(S-1)*C*E_abs;
    
end

if(pm == 1)
    
    temp1=sigma^2+(1-2*C)*E_abs^2;
    temp1=temp1/(sigma^2-C*E_abs^2);
    
    temp2=sigma^2-C*E_abs^2;
    temp2=sqrt(S*C*temp2);
    
    boundary_left=-d-C*E_abs-temp1*temp2;
    boundary_right=-d-C*E_abs+temp1*temp2;
    
    outlier=-d+(S-1)*C*E_abs;
    
end

if(pm+pc+pe+pam+pcm == 1) && (pm ~= 1) && (pc ~= 1) && (pe ~= 1) && (pam ~= 1) && (pcm ~= 1)
    
    E=C*E_abs*(pm-pc+0.5*(pam-pcm));
    V=C*sigma^2*(1-0.5*(pam+pcm))-E^2;
    beta=sqrt(S*V);
    tau=C*E_abs^2*(2*(pm+pc)+pam+pcm-1)-E^2;
    tau=tau/V;
    
    center=-d-E;
    boundary_left=center-beta*(1+tau);
    boundary_right=center+beta*(1+tau);
    
    outlier=-d+(S-1)*E;
    
end

end

