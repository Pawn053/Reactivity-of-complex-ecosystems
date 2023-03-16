function C = stable_critical_C(d, S, sigma, pm, pc, pe, pam, pcm)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

E_abs=sqrt(2/pi)*sigma; % normal distribution
%E_abs=(sqrt(3)/2)*sigma; % uniform distribution

C_step=0.00001;

if(pm==0)&&(pc==0)&&(pe==0)&&(pam==0)&&(pcm==0)
    
    pm=0.25;
    pc=0.25;
    pe=0.5;
    
end

for C=0:C_step:1
    
    E=C*E_abs*(pm-pc+0.5*(pam-pcm));
    V=C*sigma^2*(1-0.5*(pam+pcm))-E^2;
    rho=C*E_abs^2*(pm+pc-pe);
    
    beta=sqrt(S*V);
    r=(rho-E^2)/V;
    
    c=-d-E;
    a=beta*(1+r);
    
    temp1=c+a;
    temp2=-d+(S-1)*E;
    
    if(max(temp1,temp2)>0)
        break;
    end
    
end

if(C==1)&&(max(temp1,temp2)>0)
    
    C=C-C_step;
    
end

if(C<1)&&(max(temp1,temp2)>0)
    
    C=C-C_step;
    
end

end

