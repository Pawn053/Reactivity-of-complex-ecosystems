function A_interaction = interaction_existence_niche(S,C,d)
%This function generates adjacency matrix for a niche food web

%S - Number of species
%C - Connectance
%d - Self-regulation strength

temp=zeros(S,S); beta=1/C-1;

niche_value=zeros(S,1);
niche_radius=zeros(S,1);
niche_center=zeros(S,1);

for i=1:S
    niche_value(i)=rand();
end
niche_value=sort(niche_value);

for i=1:S
    B=betarnd(1,beta);
    niche_radius(i)=niche_value(i)*B;
    
    temp1=0.5*niche_radius(i);
    temp2=min(niche_value(i),1-0.5*niche_radius(i));
    niche_center(i)=temp1+(temp2-temp1)*rand();
end

for i=1:S
    for j=1:S
        if(niche_value(j)>=niche_center(i)-0.5*niche_radius(i))&&(niche_value(j)<=niche_center(i)+0.5*niche_radius(i))
            temp(j,i)=1;
        end
    end
end

for i=1:S
    temp(i,i)=-d;
end

for i=1:S
    for j=i+1:S
        if(temp(i,j)==1)&&(temp(j,i)==1)
            p=rand();
            if(p<=0.5)
                temp(j,i)=0;
            end
            if(p>0.5)
                temp(i,j)=0;
            end
        end
    end
end

A_interaction=temp;

end

