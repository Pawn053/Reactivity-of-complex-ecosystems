function A = interaction_matrix_niche(A_interaction,mu,sigma)
%This function generates interaction matrix for a niche food web based on
%normal distribution

%A_interaction - The adjacency matrix of a niche food web
%mu - Mean of the normal distribution
%sigma - STD of the normal distribution

[m,n]=size(A_interaction);
S=m;

temp=zeros(S,S);

for i=1:S
    for j=i+1:S
        
        if(A_interaction(i,j)==1)&&(A_interaction(j,i)==0)
            temp(i,j)=-abs(normrnd(mu,sigma));
            temp(j,i)=abs(normrnd(mu,sigma));
        end
        
        if(A_interaction(i,j)==0)&&(A_interaction(j,i)==1)
            temp(i,j)=abs(normrnd(mu,sigma));
            temp(j,i)=-abs(normrnd(mu,sigma));
        end
        
    end
end

for i=1:S
    temp(i,i)=A_interaction(i,i);
end

A=temp;

end

