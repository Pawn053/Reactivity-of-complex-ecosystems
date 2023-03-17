%This file provides results on the reactivity of structured food webs (i.e., cascade food web and niche food web)

%Fig. 4b can be obtained based on this file

clear; clc;
close all;

S=500; C=0.3; mu=0; d=1;

pm=0; pc=0; pe=1; pam=0; pcm=0;

X_eq=1;

sample_number=10;

sigma_start=0; sigma_step=0.01; sigma_end=0.5;

flag=1;
for sigma=sigma_start:sigma_step:sigma_end
    
    reactive_num=0;
    stable_num=0;
    for num_sample=1:sample_number
        
        %A_interaction = interaction_existence_Cascade(S,C,d);
        %A=interaction_matrix_Cascade(A_interaction,mu,sigma);
        
        A_interaction = interaction_existence_niche(S,C,d);
        A=interaction_matrix_niche(A_interaction,mu,sigma);
        
        M=X_eq*A;
        
        H=0.5*(M+M');
        
        lambda=eig(H);
        lambda_real=real(lambda);
        lambda_imag=imag(lambda);
        
        lambda_s=eig(M);
        lambda_s_real=real(lambda_s);
        lambda_s_imag=imag(lambda_s);
        
        if(max(lambda_real)>0)
            reactive_num=reactive_num+1;
        end
        
        if(max(lambda_s_real)<0)
            stable_num=stable_num+1;
        end
        
    end
    
    reactive_percent(flag)=reactive_num/sample_number;
    stable_percent(flag)=stable_num/sample_number;
    
    sigma_plot(flag)=sigma;
    
    [boundary_left, boundary_right, outlier] = eigenvalue_distribution_H_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);
    
    [boundary_left_s, boundary_right_s, outlier_s] = eigenvalue_distribution_M_the(S, C, d,sigma ,pm, pc, pe, pam, pcm);
    
    reactive_percent_the(flag)=0;
    if(max(boundary_right,outlier)>0)
        reactive_percent_the(flag)=1;
    end
    
    stable_percent_the(flag)=1;
    if(max(boundary_right_s,outlier_s)>0)
        stable_percent_the(flag)=0;
    end
    
    flag=flag+1
    
end

flag_max=max(size(sigma_plot));

critical_reactive_un=NaN;

for flag=2:flag_max
    
    if(reactive_percent_the(flag)==1)&&(reactive_percent_the(flag-1)==0)
        
        critical_reactive_un=sigma_plot(flag);
        
    end
    
end

critical_stable_un=NaN;

for flag=2:flag_max
    
    if(stable_percent_the(flag)==0)&&(stable_percent_the(flag-1)==1)
        
        critical_stable_un=sigma_plot(flag);
        
    end
    
end

critical_reactive=NaN;

for flag=2:flag_max
    
    if(reactive_percent(flag)==1)&&(reactive_percent(flag-1)<1)
        
        critical_reactive_tem1=sigma_plot(flag);
        
    end
    
    if(reactive_percent(flag)>0)&&(reactive_percent(flag-1)==0)
        
        critical_reactive_tem2=sigma_plot(flag-1);
        
    end
    
end
critical_reactive=0.5*(critical_reactive_tem1+critical_reactive_tem2);

critical_stable=NaN;

for flag=2:flag_max
    
    if(stable_percent(flag)==0)&&(stable_percent(flag-1)>0)
        
        critical_stable_tem1=sigma_plot(flag-1);
        
    end
    
    if(stable_percent(flag)<1)&&(stable_percent(flag-1)==1)
        
        critical_stable_tem2=sigma_plot(flag);
        
    end
    
end
critical_stable=0.5*(critical_stable_tem1+critical_stable_tem2);

color=colormap(lines(4));

fill([-100 critical_reactive_un critical_reactive_un -100],[100 100 -100 -100],color(1,:),'Facealpha',0.25,'Edgealpha',0);
hold on;

fill([critical_stable_un critical_reactive_un critical_reactive_un critical_stable_un],[100 100 -100 -100],color(2,:),'Facealpha',0.25,'Edgealpha',0);
hold on;

fill([critical_stable_un 100 100 critical_stable_un],[-100 -100 100 100],[0.5 0.5 0.5],'Facealpha',0.25,'Edgealpha',0);
hold on;

scatter(sigma_plot,stable_percent,'filled','MarkerFaceColor',color(1,:),'MarkerEdgeColor',color(1,:));
hold on;

scatter(sigma_plot,reactive_percent,'filled','MarkerFaceColor',color(2,:),'MarkerEdgeColor',color(2,:));
hold on;

y_plot=-10:0.1:10;

plot(critical_stable*ones(length(y_plot)),y_plot,'--','linewidth',3,'color','k');
hold on;

plot(critical_reactive*ones(length(y_plot)),y_plot,'--','linewidth',3,'color','k');
hold on;

axis([0 sigma_end -0.1 1.1]);

box on;
set(gca,'fontsize',20);