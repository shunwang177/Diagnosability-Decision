function Resulted_marking=fire_a_sequence(root_marking, Sequence, TPN)
%==given M0, sigma, this func compute M: M0[sigma> M
Pre=TPN.Pre;
Post=TPN.Post;
Resulted_marking=root_marking;
%==========
for i=1:length(Sequence)
    Resulted_marking=Resulted_marking-Pre(:,Sequence(i))+Post(:,Sequence(i));%Sequence(i) is the i-th transition
end
end