function bool=is_a_sequence_firable(Sequence,TPN,M)
%This function check whether a Sequence can fire at M
% Sequence=[1 5 6] is a transition sequence t_1t_5t_6
bool=true; %-we define sequence [] is firable
Pre=TPN.Pre;
Post=TPN.Post;
for i=1:length(Sequence)
    if any(M<Pre(:,Sequence(i)))%
        bool=false;
        return
    else
        M=M-Pre(:,Sequence(i))+Post(:,Sequence(i));%update M for next recusion
    end
end
end