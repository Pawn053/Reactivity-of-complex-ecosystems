%This file provides results on system dynamics under single perturbation
%and frequent perturbations respectively

%Fig. 5 can be obtained based on this file

clear; clc;
close all;

S=50; C=0.2; d=0.1; mu=0; sigma=0.05;

time_end=3;

community_type=1;

if(community_type==1)
    
    A_interaction=interaction_existence_FixedEdge(S,C,d);
    A=interaction_matrix(A_interaction,S,mu,sigma,0,0,1,0,0);
    
end

if(community_type==2)
    
    A_interaction=interaction_existence_Cascade(S,C,d);
    A=interaction_matrix_Cascade(A_interaction,mu,sigma);
    
end

if(community_type==3)
    
    A_interaction=interaction_existence_niche(S,C,d);
    A=interaction_matrix_niche(A_interaction,mu,sigma);
    
end

for i=1:S
    
    X_eq(i,1)=2;
    
end

num_perturbations=70;

perturbed_num=round(S*0.5);

num_perturbed_flag=randperm(S);
num_perturbed_species=num_perturbed_flag(1:perturbed_num);
[m_p,n_p]=size(num_perturbed_species);

perturbation=zeros(S,1);
for i=1:max(m_p,n_p)
    
    perturbation(num_perturbed_species(i))=3+0.4*rand();
    
end

r=-A*X_eq;

M=diag(X_eq)*A;

lambda_M=eig(M);
max(real(lambda_M))

H=0.5*(M+M');
lambda_H=eig(H);
max(lambda_H)

tspan=[0 time_end];

opts = odeset('RelTol',1e-10,'AbsTol',1e-10);

for num=1:num_perturbations
    
    if(num==1)
        
        x0{num}=X_eq+perturbation;
        
    end
    
    if(num~=1)
        
        [m,n]=size(x_simu{num-1});
        
        x0_tem=x_simu{num-1}(m,:)';
        
        x0{num}=x0_tem+perturbation;
        
    end
    
    [t_simu{num},x_simu{num}]=ode45(@(t,x)gLVFun(t,x,r,A),tspan,x0{num},opts);
    
end

for num=1:num_perturbations
    
    [m_t1,n_t1]=size(x_simu{num});
    
    for i=1:m_t1
        
        for j=1:n_t1
            
            if(x_simu{num}(i,j)>0.02)
                
                x_simu_plot{num}(i,j)=x_simu{num}(i,j);
                
            end
            
            if(x_simu{num}(i,j)<=0.02)
                
                x_simu_plot{num}(i,j)=NaN;
                
            end
            
        end
        
    end
    
end

time_end2=time_end*num_perturbations;
x0_2=X_eq+perturbation;

[t_simu2,x_simu2]=ode45(@(t,x)gLVFun(t,x,r,A),[0 time_end2],x0_2,opts);

color=colormap(lines(S));

figure(1);
for i=1:S
    
    for j=1:num_perturbations
        
        species(i)=plot(t_simu{j}+time_end*(j-1),x_simu_plot{j}(:,i),'linewidth',2,'color',color(i,:));
        hold on;
        
    end
end

axis([-inf 23 0 8.3]);

set(gca,'fontsize',25);

figure(2);
for i=1:S
    
    for j=1:num_perturbations
        
        species(i)=plot(t_simu2,x_simu2(:,i),'linewidth',2,'color',color(i,:));
        hold on;
        
    end
end

axis([-inf 57 0 8.3]);

set(gca,'fontsize',25);