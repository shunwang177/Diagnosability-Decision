function obs=Proj(Sequence,TPN)
%Proj output the observable projection of a transition sequence
%In this procedure, we only care about the sequences whose last transition
%is observable
labels=TPN.Labels;
if strcmp(labels(Sequence(end)),'eps') %the last labels is 'eps'
    disp('The last transition should be observable');
    return
end
%=initialize obs
obs={};
for i=1:length(Sequence) %for all tranistions t\in Sequence
    if ~strcmp(labels{Sequence(i)},'eps')%
        obs(end+1)=labels(Sequence(i));
    end
end
end