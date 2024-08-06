function next_edges=find_next_edge(root_node, Edge)
% this function collects the index of edges s.t. {root_node,~,~,~,~}

% Edge=[{1,'b',[5 6 ],[4 2],2}]
% a=1
next_edges=[];
for i=1:length(Edge)
    edge=Edge{i};
    if root_node==edge{1}
        next_edges=[next_edges,i];
    end
end
end