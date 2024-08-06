function [All_SP, Edge]=T_diag(M0,TPN)
%==whether a TPN system is diagnosable?

%==read the input data=======================
Tf=TPN.Tf;

%=Initialize=================================
[All_SP, Edge, ~]=Compute_SPCG(M0,TPN); % Edge=[{1,'b',[5 6 ],[4 2],2}, {...}, {...}]
is_diag=false;

% step1: read the Edge such that
edge_0={0,'start',[0],[0],1};
Edge{end+1}=edge_0;              % add a hyper-edge to the set of edges
path_0={length(Edge),'normal'};  % path ={[2 4 6],'normal'}: Edge{2}-> Edge{4}-> Edge{6} is normal
New_Pathes={path_0};

%=================================
while ~isempty(New_Pathes)

    % chosse a path from unexplored Pathes
    path=New_Pathes{1};
    New_Pathes(1)=[];
    path_vec=path{1};
    path_tag=path{2};

    % read the last node of this path and then research the next edges
    last_edge=Edge{path_vec(end)};
    last_node=last_edge{end};
    next_edges=find_next_edge(last_node,Edge);

    % each next edge leads to a new path
    if ~isempty(next_edges)

        for i=1:length(next_edges)

            % read the edge to be explored
            edge=Edge{next_edges(i)};
            sigma_2=edge{4};             % edge={1,'b',[5 6 ],[4 2],2}
            reached_node=edge{end};
            %--------------------------------------------------------
            new_path_vec=[path_vec, next_edges(i)];
            new_path_tag='uncertain'; % compute the next tag
            if strcmp(path_tag,'normal')&& isempty(intersect(sigma_2,Tf))
                new_path_tag='normal';
            end
            %---------------------
            if is_duplicated(reached_node,new_path_vec,Edge)
                if strcmp(new_path_tag,'uncertain')
                    disp('The system is not diagnosable');
                    disp('The string of edges serves a counter-example:');
                    disp(new_path_vec(2:end));
                    for j=2:length(new_path_vec)
                        disp(Edge{new_path_vec(j)});
                    end
                    return
                end
            else
                %-further exploration if the reached_node is not duplicated
                new_path={new_path_vec,new_path_tag};
                New_Pathes{end+1}=new_path;
            end
        end

    end
end
disp('The system is diagnosable');
end