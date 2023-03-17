function A_interaction = interaction_existence_Cascade(S,C,d)
%This function generates adjacency matrix for a cascade food web

%S - Number of species
%C - Connectance
%d - Self-regulation strength

temp=zeros(S,S);

for i=1:S
    for j=i+1:S
        p1=rand();
        if(p1<=C)
            temp(i,j)=1;
        end
    end
end

for i=1:S
    temp(i,i)=-d;
end

A_interaction=temp;

end

