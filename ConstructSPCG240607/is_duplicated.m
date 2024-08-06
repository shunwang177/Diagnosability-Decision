function bool=is_duplicated(reached_node,new_path_vec,Edge)
% whether the 'reached node' is duplicate during the path?

passed_node=[];
for i=1:length(new_path_vec)-1
    edge=Edge{new_path_vec(i)}; % edge={1,'b',[5 6 ],[4 2],2}
    passed_node=[passed_node, edge{1}, edge{end}];
end
bool=ismember(reached_node,passed_node);
end