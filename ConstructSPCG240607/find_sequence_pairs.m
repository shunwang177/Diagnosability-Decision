function Sequence_Pairs=find_sequence_pairs(M1, M2, TPN)
%given a marking pair M1, M2, find out all of the indistinguishable
%transition sequence pairs s.t. M1[s1>, M2[s2>, Proj(s1)=Proj(s2),
%s1 is normal
%output={{[1 2 3],[4 5 6]},{[...],[...]},...}
%====================================================================
%=load datas
labels=TPN.Labels;
Tf=TPN.Tf;
%=the set of observable labels
obs_labels=setdiff(unique(labels),'eps');
%=Initialize
Sequence_Pairs={};
Sequence_1=find_observable_sequences(M1,TPN);
Sequence_2=find_observable_sequences(M2,TPN);
%=== Sequence_Pairs= Sequence_1  \times  Sequence_2
for i=1:length(Sequence_1)
    %=if Sequence_1{i} is normal
    if isempty(intersect(Sequence_1{i},Tf))
        for j=1:length(Sequence_2)
            %if proj(\sigma_i)=proj(\sigma'_j), collect (\sigma_i,\sigma'_j)
            if strcmp(Proj(Sequence_1{i},TPN), Proj(Sequence_2{j},TPN))
                Sq_pair={Sequence_1{i}, Sequence_2{j}};
                Sequence_Pairs{end+1}=Sq_pair;
            end
        end
    end
end
end