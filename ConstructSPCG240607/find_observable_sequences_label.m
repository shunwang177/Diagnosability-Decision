function Sequences=find_observable_sequences_label(label, initialMarking,TPN)
%Given a marking [0 0 1 0 0]' and a label 'a',
% this function returns the set of transition sequences feasible at the Marking and ended with 'label'.
%This function requires that the net struction contains no unobservable
%cycles.

%=load datas
labels=TPN.Labels;
Pre=TPN.Pre;
Post=TPN.Post;
%=the set of observable labels
obs_labels=setdiff(unique(labels),'eps');
%=====initialize=================================
Sequences={};%with a form {[1 2 3], [2 3]}, which means t1 t2 t3 and t2 t3 are firable
queue={{initialMarking,[]}}; %To be explored
%===============================================
while ~isempty(queue)
    %=read an entry from queue
    current=queue{1};
    queue(1)=[];
    %=read current node
    marking=current{1};
    fired_sequence=current{2};
    %=for all transitions t \in T
    for i=1:length(Pre)
        %=is t_i firable at marking?
        if all(marking>=Pre(:,i))
            %=fire this marking and update new marking
            new_marking=marking-Pre(:,i)+Post(:,i);
            new_sequence=[fired_sequence, i];
            %=if the last transition is not observable, add it to queue for further computation
            %=else if it consistent with the 'label', add the sequence to the result;
            if ~ismember(labels(i),obs_labels)
                queue{end+1}={new_marking, new_sequence};
            elseif strcmp(labels(i),label)
            Sequences{end+1}=new_sequence;
            end
        end
    end
end

end