%This file plots the critical C-S curve for the transition from
%non-reactive state to reactive state

%Fig. 2b, Fig. 3a can be obtained based on this figure

clear; clc;
close all;

d=1; mu=0; sigma=0.1;

S_step=1;
S_plot_end=1700;

X_eq=1;

p_interaction{1}=[0 0 0 0 0];
p_interaction{2}=[0 0 1 0 0];
p_interaction{3}=[0.5 0.5 0 0 0];
p_interaction{4}=[0 1 0 0 0];
p_interaction{5}=[1 0 0 0 0];

for community_type=1:5

    pm=p_interaction{community_type}(1);
    pc=p_interaction{community_type}(2);
    pe=p_interaction{community_type}(3);
    pam=p_interaction{community_type}(4);
    pcm=p_interaction{community_type}(5);
    
    flag=1;
    for S=0:S_step:2000
        
        C_critical{community_type}(flag)=reactive_critical_C(d, S, sigma, pm, pc, pe, pam, pcm);
        flag=flag+1;
        
    end
    
end

S_plot=0:S_step:S_plot_end;
plot_num=max(size(S_plot));
for community_type=1:5
    %p{community_type}=plot(S_critical{community_type},C_plot,'linewidth',2);
    p{community_type}=scatter(S_plot,C_critical{community_type}(1:plot_num),'filled');
    hold on;
end

axis([-100 1500 -0.03 0.33]);

grid on;
box on;

set(gca,'xtick',[0 500 1000 1500]);
set(gca,'ytick',[0 0.1 0.2 0.3]);

xl=xlabel('\it{S}');
yl=ylabel('\it{C}');
set(yl,'rotation',0);

l1=legend([p{1},p{2},p{3},p{4},p{5}],{'Random','+/-','Mixture','-/-','+/+'});
set(l1,'box','off');
set(gca,'fontsize',25);