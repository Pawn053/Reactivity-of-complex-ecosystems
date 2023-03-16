%This file plots both the eigenvalue distribution of the simulated H matrix
%and the boundary estimated by our theory

%The first row of Fig. 2a can be obtained based on this file

clear; clc;
close all;

S=100; C=0.5; d=0;

mu=0; sigma=0.15;

X_eq=1;

pm=0; pc=1; pe=0; pam=0; pcm=0;

for num=1:10
    
    A_interaction=interaction_existence_FixedEdge(S,C,d);
    A=interaction_matrix(A_interaction, S, mu, sigma, pm, pc, pe, pam, pcm);
    
    %A_interaction=interaction_existence_Cascade(S,C,d);
    %A=interaction_matrix_Cascade(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_Cascade_wilder_degree_distribution(S,C,d);
    %A=interaction_matrix_Cascade(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_Cascade_interval(S,C,d);
    %A=interaction_matrix_Cascade(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_Cascade_wilder_d_distribution_interval(S,C,d);
    %A=interaction_matrix_Cascade(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_niche(S,C,d);
    %A=interaction_matrix_niche(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_bipartite(S,C,d);
    %A=interaction_matrix_bipartite(A_interaction,mu,sigma);
    
    %A_interaction=interaction_existence_bipartite_nested(S,C,d);
    %A=interaction_matrix_bipartite_nested(A_interaction,mu,sigma);
    
    M=X_eq*A;
    
    H=0.5*(M+M');
    
    lambda=eig(H);
    lambda_real=real(lambda);
    lambda_imag=imag(lambda);
    
    s{num}=scatter(lambda_real, lambda_imag,100,'filled');
    hold on;
    
end

[left, right, outlier] = eigenvalue_distribution_H_the(S, C, d, sigma, pm, pc, pe, pam, pcm);
sl=scatter(left,0,120,'black','filled');
hold on;
scatter(right,0,120,'black','filled');
hold on;
if(outlier<left)||(outlier>right)
    scatter(outlier,0,120,'black','filled');
end

%axis([-2.5 2.5 -1.2 1.2]);

xlabel('Real');
ylabel('Imaginary');

l1=legend([s{10},sl],{'Simulation','Theory'});
set(l1,'location','best','box','off');

box on;
set(gca,'fontsize',20);