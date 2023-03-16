%This file provides both simulated and theoretical results on the
%relationship between community complexity and the percentage of reactive
%communities

%The second row of Fig. 2a can be obtained based on this file

clear; clc;
close all;

S=150; C=0.5; mu=0; sigma=0.1; d=1;

pm=0; pc=0; pe=1; pam=0; pcm=0;

X_eq=1;

sample_number=10;

complexity_start=0; complexity_step=0.01; complexity_end=1.5;

flag=1;
for complexity_flag=complexity_start:complexity_step:complexity_end
    
    C=complexity_flag^2/(sigma^2*S);
    
    reactive_num=0;
    for num_sample=1:sample_number
        
        A_interaction=interaction_existence_FixedEdge(S, C, d);
        A=interaction_matrix(A_interaction,S,mu,sigma,pm,pc,pe,pam,pcm);
        
        M=X_eq*A;
        
        H=0.5*(M+M');
        
        lambda=eig(H);
        lambda_real=real(lambda);
        lambda_imag=imag(lambda);
        
        if(max(lambda_real)>0)
            reactive_num=reactive_num+1;
        end
        
    end
    
    reactive_percent(flag)=reactive_num/sample_number;
    complexity(flag)=sigma*sqrt(S*C);
    
    [boundary_left, boundary_right, outlier] = eigenvalue_distribution_H_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);
    
    reactive_percent_the(flag)=0;
    if(max(boundary_right,outlier)>0)
        reactive_percent_the(flag)=1;
    end
    
    flag=flag+1
    
end

scatter(complexity,reactive_percent,'filled');
hold on;
plot(complexity,reactive_percent_the,'linewidth',2);

box on;
set(gca,'fontsize',20);