%This file provides results on the critical C ratio for communities with
%mixed interaction types

%Fig. 3c can be obtained based on this file

clear; clc;
close all;

S=900; d=1; sigma=0.2;

p_start=0; p_step=0.01; p_end=1;

pam=0; pcm=0;

flag1=1;
for pm=p_start:p_step:p_end
    
    for pc=p_start:p_step:p_end
        
        for pe=p_start:p_step:p_end
            
            if(pm+pc+pe==1)
                
                stable_length=stable_critical_C(d, S, sigma, pm, pc, pe, pam, pcm);
                nonreactive_length=reactive_critical_C(d, S, sigma, pm, pc, pe, pam, pcm);
                
                if(stable_length~=1)
                
                    ratio=nonreactive_length/stable_length;
                    
                end
                
                if(stable_length==1)
                    
                    ratio=0;
                    
                end
                
                results(flag1,1)=pm;
                results(flag1,2)=pc;
                results(flag1,3)=pe;
                results(flag1,4)=ratio;
                
                flag1=flag1+1;
                
            end
            
        end
        
    end
    
end

[hg,htick,hcb]=tersurf(results(:,1),results(:,2),results(:,3),results(:,4));

caxis([0 1]);

hlabels=terlabel('Pm','Pc','Pe');