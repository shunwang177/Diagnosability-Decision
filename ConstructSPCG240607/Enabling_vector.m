function E_Vec=Enabling_vector(transition, Marking, Sequence, TPN)
%This function returns the enabling vector of a transition sequence
%transition=5 means t5
if ~is_a_sequence_firable(Sequence,TPN,Marking)
    disp('the sequence is infeasible at the Marking');
    return
end
%===================================================
%=initialize the E_Vec
E_Vec=ones(1, length(Sequence)+1);
Reset_Point=[];                         %Reset_Point=[1, 2] means the clocks of the transition are discarded as t1 t2 firing
%=load data
Pre=TPN.Pre;
Post=TPN.Post;
%=====================================================
if isempty(Sequence)
    E_Vec=1;
    return
end
%=from the 1-th to the end-th transition in the Sequence
for i=1:length(Sequence)
    %=if (i-th transition==t) or (t is reset by t_i)
    if (Sequence(i)==transition)||(any(Marking-Pre(:,Sequence(i))<Pre(:,transition)))
        %=record the new reset point
        Reset_Point=[Reset_Point, i];
    end
    %=update marking
    Marking=Marking-Pre(:,Sequence(i))+Post(:,Sequence(i));
end
%=if the clock of trans used to be reseted/discarded
if ~isempty(Reset_Point)
    %=if so, set the E_vec
    E_Vec(1:max(Reset_Point,[],"all")+1)=0;
end
%eg: Sequence=[1 4 3], the corresponding Time Transition Sequence is x1 t1
%x2 t4 x3 t3, E_vec=[0 0 1 1] means that the clock of the transition equals
%to x2+x3
end