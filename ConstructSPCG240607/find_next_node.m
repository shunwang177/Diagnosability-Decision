function [next_nodes,sigma_2]=find_next_node(a, Edge)
% this function collects the next node of a

% Edge=[{1,'b',[5 6 ],[4 2],2}]
% a=1
next_nodes=[];
for i=1:length(Edge)
    edge=Edge{i};
    if a==edge{1}
        next_nodes=[next_nodes,edge{end}];
    end
end
next_nodes=unique(next_nodes);
end